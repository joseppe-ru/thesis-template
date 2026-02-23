import tkinter as tk
from tkinter import ttk
import simpy
import threading
import time
from datetime import datetime
import requests
from PIL import Image, ImageTk

# Use-Case Labels and Values

button_labels = [
    "Hohe Belastung/Verstopfung",
    "Abatement-Rückstau",
    "Abatement-Rückstau & Pumpenfehler",
    "Pumpenausfall mit Rückstau",
    "Verschmutzung erkannt",
    "Optimaler Betrieb",
    "Leckage / Pumpenfehler",
    "Rohrbruch",
    "Rohr verstopft",
    "Leckage",
    "Pumpendefekt / Verschleiß",
    "Systemfehler / Inaktivität",
    "Vollständiger Rohrverschluss",
    "Sensorfehler",
    "Pumpendefekt (Kein Druck)",
    "Pumpe inaktiv / Verklemmt"
]

use_case_values = {
    0: (130, 130),
    1: (110, 130),
    2: (70, 130),
    3: (0, 130),
    4: (130, 110),
    5: (100, 100),
    6: (70, 100),
    7: (0, 100),
    8: (130, 70),
    9: (110, 70),
    10: (70, 70),
    11: (0, 70),
    12: (130, 0),
    13: (100, 0),
    14: (70, 0),
    15: (0, 0)
}

header_labels = ["über Toleranz", "innerhalb Toleranz", "unter Toleranz", "kein Druck"]

class SimulationApp:
    def __init__(self, root, env):
        self.root = root
        self.env = env
        # Control flag for shutting down 
        self.running = True  
        # Shared variables
        self.actual_pressure_pump = 0
        self.actual_pressure_abatement = 0
        self.target_pressure_pump = 0
        self.target_pressure_abatement = 0
        self.flag_pump = 0
        self.flag_abatement = 0
        self.use_cases(0)

        # REST-API
        # TODO: get the REST-API endpoints dynamicaly (stuck here till connection with aas-server is established)
        (self.pump_pressure_url, self.abatement_pressure_url) = self.get_rest_api_endpoints()
        
        # Build GUI
        self.setup_gui()

        # Simulation and REST in seperate threads
        self.sim_thread = threading.Thread(target=self.run_simulation, daemon=True)
        self.sim_thread.start()
        self.rest_thread = threading.Thread(target=self.rest_update, daemon=True)
        self.rest_thread.start()

        # Register a Process for SimPy
        self.pump_proc = env.process(self.pump(env)) 

        # Schedule GUI Update
        self.root.after(100, self.update_gui) 

        # Set Closing callback
        self.root.protocol("WM_DELETE_WINDOW", self.on_close)
    

    # ==> Everything from Simulation <==
    # Pump thread is for updating Values from the AAS
    def pump(self,env):
        factor = 0.01
        while self.running:
            self.actual_pressure_pump += (self.target_pressure_pump - self.actual_pressure_pump) * factor
            self.actual_pressure_abatement += (self.target_pressure_abatement - self.actual_pressure_abatement) * factor

            self.actual_pressure_pump = round(self.actual_pressure_pump, 3)
            self.actual_pressure_abatement = round(self.actual_pressure_abatement, 3)

            # Näherungs-Toleranz definieren
            epsilon = 0.1

            # Wenn nahe genug: exakt setzen
            if abs(self.actual_pressure_pump - self.target_pressure_pump) < epsilon:
                self.actual_pressure_pump = self.target_pressure_pump

            if abs(self.actual_pressure_abatement - self.target_pressure_abatement) < epsilon:
                self.actual_pressure_abatement = self.target_pressure_abatement

            yield env.timeout(2)


    def run_simulation(self):
        try:
            while self.running:
                self.env.run(until=self.env.now + 10)  # Run in increments
                time.sleep(0.1)
        except Exception as e:
            print(f"Simulation error: {e}")
        finally:
            print("Simulation stopped")
                
    def get_use_case_label(self, index):
        return button_labels[index] if index < len(button_labels) else "Unbekannt"

    def use_cases(self, val):
        (self.target_pressure_pump, self.target_pressure_abatement) = use_case_values.get(val, (0, 0))  # Standardwerte für unbekannte Fälle
              
    # ==> Everything for GUI <==
    def setup_gui(self):
        main_frame = ttk.Frame(self.root)
        main_frame.pack(fill="both", expand=True)

        # left Side (Pumpe)
        self.left_frame = ttk.Frame(main_frame, padding="10")
        top_frame_pump = ttk.Frame(self.left_frame)
        # Picture Pumpe
        im = Image.open("images/pump.jpg")
        im = im.resize((100, 100), Image.NEAREST)
        tk_image = ImageTk.PhotoImage(im)
        self.pump_image = tk_image
        self.label_image_pump = tk.Label(top_frame_pump, image=self.pump_image)
        self.label_image_pump.pack(side="left", padx=5)
        # Stats Pump
        self.label_stats_pump = tk.Text(top_frame_pump, width=30, height=10, wrap="word")
        self.label_stats_pump.insert("1.0", "Pumpen-Status\n\nDruck: 0 mBar\nTemperatur: 25°C\nLeistung: 75%")
        self.label_stats_pump.pack(side="left", padx=5)
        top_frame_pump.pack(pady=5)
        # Pressure Pump
        self.label_pressure_pump = tk.Label(self.left_frame, text="0 mBar", font=("Arial", 10, "bold"), anchor="center")
        self.label_pressure_pump.pack(pady=5)
        self.left_frame.pack(side="left", fill="both", expand=True)

        # Separator
        separator = ttk.Separator(main_frame, orient="vertical")
        separator.pack(side="left", fill="y", padx=5)

        # Right side (Abatement)
        self.right_frame = ttk.Frame(main_frame, padding="10")
        top_frame_abatement = ttk.Frame(self.right_frame)
        # Picture Abatement
        im = Image.open("images/abatement.png")
        im = im.resize((100, 100), Image.NEAREST)
        tk_image = ImageTk.PhotoImage(im)
        self.image_abatement = tk_image
        self.label_image_abatement = tk.Label(top_frame_abatement, image=self.image_abatement)
        self.label_image_abatement.pack(side="left", padx=5)
        # Stats
        self.label_stats_abatement = tk.Text(top_frame_abatement, width=30, height=10, wrap="word")
        self.label_stats_abatement.insert("1.0", "Abatement-Status\n\nDruck: 0 bar\nDurchfluss: 120 l/min\nEffizienz: 92%")
        self.label_stats_abatement.pack(side="left", padx=5)
        top_frame_abatement.pack(pady=5)
        # Pressure Abatement
        self.label_pressure_abatement = tk.Label(self.right_frame, text="0 mBar", font=("Arial", 10, "bold"), anchor="center")
        self.label_pressure_abatement.pack(pady=5)  
        self.right_frame.pack(side="left", fill="both", expand=True)

        # Time Display
        self.time_frame = ttk.Frame(self.root)
        self.time_frame.pack(fill="x", pady=10)
        self.label_time = ttk.Label(self.time_frame, text="Zeit: 00:00:00", font=("Arial", 12))
        self.label_time.pack()

        # Buttons to Trigger Use-Cases
        title_frame = ttk.Frame(self.root)
        title_frame.pack(pady=10)
        ttk.Label(title_frame, text="Use-Cases", font=('Arial', 16, 'bold')).pack() # Überschrift
        self.button_frame = ttk.Frame(self.root)
        self.button_frame.pack(pady=20)
        self.create_buttons_with_grid(self.button_frame)

        # Manuel Pressure Adjustment (PopUp)
        popup_btn = ttk.Button(root, text=f"Druckwerte Manuell anpassen", command=self.open_popup)
        popup_btn.pack(pady=10)

        # Button to Stop Simulation
        stop_button = tk.Button(root, text=f"Stop Simulation", command=self.on_close, fg='white', bg='red')
        stop_button.pack(pady=10)


    def create_buttons_with_grid(self, parent_frame):
        # Tabelle für Use-Cases mit Toleranz-Bezeichnungen
        ttk.Label(parent_frame, text="Abatement / Pumpe", relief="ridge").grid(row=0, column=0, padx=2, pady=2, sticky="nsew")
        for col_idx, header_text in enumerate(header_labels):
            ttk.Label(parent_frame, text=header_text, font=('Arial', 9, 'bold'), relief="ridge") \
                .grid(row=0, column=col_idx + 1, padx=2, pady=2, sticky="nsew")
        for row_idx, side_text in enumerate(header_labels):
            ttk.Label(parent_frame, text=side_text, font=('Arial', 9, 'bold'), relief="ridge") \
                .grid(row=row_idx + 1, column=0, padx=2, pady=2, sticky="nsew")
        max_internal_columns = 4
        row_offset = 1
        column_offset = 1
        # Buttons mit entprecheneden Labels für Use-Cases (in Tabelle eintragen)
        for i in range(0, len(button_labels)):
            button_relative_row = i // max_internal_columns
            button_relative_column = i % max_internal_columns
            grid_row = button_relative_row + row_offset
            grid_column = button_relative_column + column_offset
            btn = ttk.Button(parent_frame, text=self.get_use_case_label(i), command=lambda i=i: self.use_cases(i))
            btn.grid(row=grid_row, column=grid_column, padx=2, pady=2, sticky="nsew")

    def open_popup(self):
        def popup_on_close():
            try:
                val1 = int(entry1.get())
                val2 = int(entry2.get())
                if 0 <= val1 <= 300 and 0 <= val2 <= 300:
                    # print(f"\nEingegebene Werte: {val1}, {val2}\n")
                    self.target_pressure_pump = val1
                    self.target_pressure_abatement = val2
                else:
                    print("Druckwerte out of bound!")
            except ValueError:
                print("Bitte gültige Zahlen eingeben.")
            popup.destroy()
        popup = tk.Toplevel(self.root)
        popup.title("Gewünschte Druckwerte eingeben")
        popup.geometry("300x200")
        tk.Label(popup, text="Druck Pumpe: [mBar]").pack(pady=5)
        entry1 = tk.Entry(popup)
        entry1.pack(pady=5)
        tk.Label(popup, text="Druck Abatement: [mBar]").pack(pady=5)
        entry2 = tk.Entry(popup)
        entry2.pack(pady=5)
        close_btn = ttk.Button(popup, text=f"Übernehmen & Schließen", command=popup_on_close)
        close_btn.pack(pady=10)


    # Updating Textboxes and values to Display
    def update_gui(self):
        if not self.running:
            self.root.quit()
            return
        # Update GUI elements with the current state of the simulation
        self.label_pressure_pump.config(text = f"{self.actual_pressure_pump:.1f} mBar")
        self.label_pressure_abatement.config(text = f"{self.actual_pressure_abatement:.1f} mBar")
        self.label_time.config(text=f"Zeit: {datetime.now().strftime('%H:%M:%S')}")
        self.root.after(200, self.update_gui) # Schedule next GUI update


    def on_close(self):
        self.running = False
        self.root.quit()


    # ==> Everything for REST-API <==
    def get_rest_api_endpoints(self):
        pump_pressure_url = "http://localhost:8081/submodels/ aHR0cHM6Ly9leGFtcGxlLmNvbS9pZHMvc20vMzI1NF81MTYyXzUwNTJf MTk5NQ==/submodel-elements/SetPressure/$value"
        abatement_pressure_url = "http://localhost:8081/submodels/ aHR0cHM6Ly9leGFtcGxlLmNvbS9pZHMvc20vNjE2NF81MTYyXzUwNTJf NDE3Nw==/submodel-elements/SetPressure/$value"
        return (pump_pressure_url, abatement_pressure_url)
    
    def rest_update(self):
        headers = {"accept":"application/json","Content-Type": "application/json"}
        while self.running:
            try:
                # Pump Pressure
                pump_response = requests.patch(self.pump_pressure_url, headers=headers, data=f'"{self.actual_pressure_pump}"')
                if pump_response.status_code == 204:
                    print(f"Pump pressure set to {self.actual_pressure_pump} mBar")
                else:
                    print(f"Failed to set pump pressure: {pump_response.status_code} - {pump_response.text}")

                # Abatement Pressure
                abatement_response = requests.patch(self.abatement_pressure_url, headers=headers, data=f'"{self.actual_pressure_abatement}"')
                if abatement_response.status_code == 204:
                    print(f"Abatement pressure set to {self.actual_pressure_abatement} mBar")
                else:
                    print(f"Failed to set abatement pressure: {abatement_response.status_code} - {abatement_response.text}")

            except requests.exceptions.RequestException as e:
                print(f"REST API error: {e}")

            time.sleep(1)



# ==> Setup Environment <==
root = tk.Tk() # Tkinter 
env = simpy.Environment() # SimPy
app = SimulationApp(root, env) # Simulation App

root.mainloop()
try:
    root.mainloop()
finally:
    app.running = False

print("Finished?")
