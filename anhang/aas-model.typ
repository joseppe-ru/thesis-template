= Struktureller Aufbau der Verwaltungsschale <appendix:aasx-model>

// <strucktureller-aufbau-der-verwaltungsschale>
- #strong[Shell:] SemiconductorX (Parent)

  - #strong[Sub:] Nameplate
    #link(
      "https://github.com/admin-shell-io/submodel-templates/tree/main/published/Digital%20nameplate/3/0",
    )[\[Template-Git\]]

- #strong[Shell:] IndustrialExhausPump (Child)

  - #strong[Sub:] Nameplate
    #link(
      "https://github.com/admin-shell-io/submodel-templates/tree/main/published/Digital%20nameplate/3/0",
    )[\[Template-Git\]]

  - #strong[Sub:] TechnicalData
    #link(
      "https://github.com/admin-shell-io/submodel-templates/tree/main/published/Asset%20Interfaces%20Description/1/0",
    )[\[Template-Git\]]

  - #strong[Sub:] OperationalData

    - #strong[Prop:] ActualPressure

- #strong[Shell:] AbatementSystem (Child)

  - #strong[Sub:] Nameplate
    #link(
      "https://github.com/admin-shell-io/submodel-templates/tree/main/published/Digital%20nameplate/3/0",
    )[\[Template-Git\]]

  - #strong[Sub:] TechnicalData
    #link(
      "https://github.com/admin-shell-io/submodel-templates/tree/main/published/Asset%20Interfaces%20Description/1/0",
    )[\[Template-Git\]]

  - #strong[Sub:] OperationalData

    - #strong[Prop:] ActualPressure

