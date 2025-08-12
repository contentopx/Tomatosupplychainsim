# 🍅 Chapter 2 – Operational Modeling of Postharvest Tomato Losses, Water, and Energy Use

This folder contains the **deterministic operational optimization model** for Florida’s fresh-market tomato supply chain.  
It is the foundation of my PhD research and provides baseline loss estimates, resource usage, and economic performance.

---

## 📄 Research Context
This model was adapted from the framework by Ahumada & Villalobos (2011) and restructured for Florida’s **packinghouse → repacker → distribution center → retail** flow (Figure 2-2, dissertation).  
It explicitly accounts for **water and energy use** at each stage, alongside quality-driven postharvest loss (PHL).

The work in this chapter is published in:  
> Suthar, R.G., Judge, J., Brecht, J.K., Pelletier, W., & Muneepeerakul, R. (2019).  
> *Modeling postharvest loss and water and energy use in Florida tomato operations*.  
> Postharvest Biology and Technology, 151, 91–102.  
> [https://doi.org/10.1016/j.postharvbio.2019.01.011](https://doi.org/10.1016/j.postharvbio.2019.01.011)

---

## 🛠 What’s Inside
- `CleanOpermodel.mod` – GAMS/AMPL operational model for Florida tomato flows.
- `OperationalFL.run` – Solver run file for model execution.
- `pubinput.xls` – Input dataset from a representative Florida grower-shipper.
- `README.md` – This documentation.

---

## ⚙ How It Works
1. **Objective**: Maximize grower-shipper profit while tracking PHL, water use, and energy use.
2. **Inputs**:
   - Crop maturity distributions.
   - Market prices and transport costs.
   - Handling loss rates by stage.
3. **Outputs**:
   - Shipment schedules.
   - Losses (lbs) and packout % at each stage.
   - Resource consumption (water, kWh).

---

## 📊 Key Results
Peer-reviewed results from [Suthar et al. 2019](https://doi.org/10.1016/j.postharvbio.2019.01.011):

- **PHL (representative grower)**: 22%
- **Statewide upscaled PHL**: 16% (~408M lbs/year)
- **Loss hotspots**: Packinghouse and Distribution Center stages.
- **Optimization potential**: ~8% loss reduction possible without increasing costs.
- **Resource efficiency**: Optimized scenarios used ~20% less water and energy than actual operations.
- **Statewide monthly resource use**:
  - ~50.3 million liters of water
  - ~28.3 million kWh of energy
- **System behavior insight**: Overproduction driven by risk-aversion and fixed-cost pressures increases unnecessary loss.


---

## ▶ How to Run

# Requires GAMS or AMPL installed
1. gams OperationalFL.run
Ensure pubinput.xls is in the working directory.

📚 Citation
If using this model, please cite:

Suthar, R.G., Judge, J., Brecht, J.K., Pelletier, W., & Muneepeerakul, R. (2019).
Modeling postharvest loss and water and energy use in Florida tomato operations.
Postharvest Biology and Technology, 151, 91–102.
https://doi.org/10.1016/j.postharvbio.2019.01.011
