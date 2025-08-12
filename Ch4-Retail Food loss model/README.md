# 🛡 Chapter 4 – Robust Optimization for Retail-Level Loss Reduction

This chapter develops a **robust optimization (RO)** model for the retail stage of the Florida tomato supply chain, building on the uncertainty framework from Chapter 3.  
The goal: make stocking and donation decisions that perform well **even under worst-case environmental and operational conditions**.

---

## 📄 Research Context
Retail operations are where consumer-facing quality issues and food waste converge.  
Losses here are driven by:
- Storage temperature fluctuations.
- Ripeness on arrival.
- Freshness-dependent consumer demand.

This chapter links postharvest uncertainty to **retail-level economic outcomes and food recovery potential**.

---

## 💡 Why Robust Optimization?
While Monte Carlo simulations (Chapter 3) show how uncertainty affects outcomes, **robust optimization** actively *plans for the worst case*.  
The model ensures decisions are:
- **Resilient** to adverse conditions.
- **Stable** across uncertainty ranges.
- **Practical** for retailer use without needing perfect forecasts.

This approach improves:
- Loss prevention.
- Donation strategies.
- Profit stability.

---

## 🛠 What’s Inside
- `retq3cleandemand.mod` – Robust optimization model.
- `RO.run` – GAMS run file for executing the model.
- `tablegenRO.py` – Python script to generate synthetic uncertainty scenarios.
- Input CSV/Excel files – Baseline retail data.

---

## ⚙ How It Works
1. **Synthetic Data Generation**  
   - `tablegenRO.py` creates randomized retail scenarios (temperature, ripeness, demand) based on probability distributions calibrated from literature and industry data.
2. **Model Execution**  
   - The robust optimization model solves for stocking and donation quantities that perform best in the *worst-case subset* of scenarios.
3. **Outputs**  
   - Retailer profit.
   - Postharvest loss (PHL).
   - Volume donated.

---

## 📊 Key Results
From the dissertation analysis:
- **Baseline retail PHL**: 25% ± 4%.
- Adding realistic uncertainty increased losses by ~2–3%.
- **Robust strategies**:
  - Cut losses by 6–7% in worst-case conditions.
  - Maintained profitability within 2% of baseline.
- Sensitivity analysis: donation payoff & temperature had the largest influence on results.

---


## ▶ How to Run

# Step 1: Generate input tables
python tablegenRO.py

# Step 2: Run the robust optimization model
gams RO.run
Make sure all input files are in the working directory.

📚 Citation
If using this model, please cite:<br>

>Suthar, R.G. (2021). Modeling Postharvest Losses in the Florida Tomato System.<br>
>PhD Dissertation, University of Florida. Chapter 4.
