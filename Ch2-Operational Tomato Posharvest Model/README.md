# 🍅 Chapter 2 – Operational Modeling of Postharvest Tomato Losses

Welcome to the code & data for **Chapter 2** of my PhD, where I built the first computational model to map and optimize **postharvest tomato flows in Florida’s tomato supply chain**.

This chapter focuses on:
- Identifying where losses happen after harvest.
- Simulating operational changes to reduce waste.
- Optimizing transport, storage, and packing decisions.

## What's Inside
- **CleanOpermodel.mod** – The core optimization model (GAMS/AMPL).
- **OperationalFL.run** – Run file that powers the simulations.
- **pubinput.xls** – Florida tomato system input data.
- **README.md** – You’re reading it.

## Highlights
- Real Florida tomato supply chain data 🍅
- Modular and reusable code.
- Built for scenario testing and sensitivity analysis.

## How to Run
1. Install GAMS or AMPL (solver required).
2. Keep `pubinput.xls` in your working directory.
3. Run:
   ```bash
   gams OperationalFL.run
