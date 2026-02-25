#!/bin/bash

# BaSyx AAS Services starten
echo ">>> Starte BaSyx AAS Services..."
cd ./basyx_aas_services
docker compose up -d
cd ..

# Simulator Starten
echo ">>> Starte den Pumpensimulator"
cd ./python_simulator/
source ./venv/bin/activate

echo ">>> Prüfe Python-Abhängigkeiten..."
python3 -c "import simpy, requests, PIL, tkinter" 2>/dev/null
if [ $? -ne 0 ]; then
  echo "FEHLER: Abhängigkeiten fehlen!"
  exit 1
fi
pip show Pillow >/dev/null 2>&1 || echo "Warnung: Pillow nicht lokal installiert."

python3 drucksimulator.py >simulator.log 2>&1 &
cd ..

# EDC starten
echo ">>> Starte EDC..."
cd ./EDC
docker compose up -d
cd ..

# AAS Client bauen und starten
echo ">>> Baue und starte AAS Client..."
cd ./aas_client
docker compose up -d --build
cd ..

echo ">>> Alle Setups wurden verarbeitet."
docker ps --format "{{.Names}}"

# Websiten aufrufen+ "/submodel-elements/SetPressure/$value"
echo " "
echo "Hier gehts zu den Websiten:"
echo "BaSyx AAS-Package Viewer: http://localhost:3000/"
echo "Grafana: http://localhost:3001/"
