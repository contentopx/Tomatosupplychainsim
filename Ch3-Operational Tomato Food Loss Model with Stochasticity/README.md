## **Ch3-main README**

# 🎲 Chapter 3 – Monte Carlo Simulation for Tomato Loss Scenarios

Chapter 3 takes the Florida tomato system model to the next level by adding **uncertainty**.  
We ran **Monte Carlo simulations** to see how weather, handling, and demand shifts change loss patterns.

## What's Inside
- **CleanOpermodel.mod** – Base operational model.
- **OperMCordered.run** – Simulation run script for stochastic scenarios.
- **COLtablegen** – Generates data tables for simulation runs.
- **input2.xlsx** – Scenario input dataset.

## Highlights
- 1,000+ stochastic runs for robust insights.
- Ordered scenario evaluation for easier comparisons.
- Real-world variability baked right into the model.

## How to Run
1. Install GAMS/AMPL.
2. Place `input2.xlsx` and `COLtablegen` in your working directory.
3. Run:
   gams OperMCordered.run
Review simulation outputs.
