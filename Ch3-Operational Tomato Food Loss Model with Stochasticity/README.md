# 🎲 Chapter 3 – Monte Carlo Simulation of Uncertainty in Postharvest Operations

This chapter extends the deterministic model from Chapter 2 to incorporate **biophysical uncertainty** in postharvest operations (PO) for Florida tomatoes.

We created **synthetic datasets** to simulate thousands of realistic operational scenarios, allowing us to quantify how environmental variability, product maturity, and handling delays impact postharvest losses (PHL) and economic outcomes.

---

## 📄 Research Context
The Florida tomato supply chain experiences variability in:
- **Storage temperature** – due to weather, equipment performance, and handling.
- **Initial maturity** – mix of maturity stages at harvest.
- **Time duration** – delays during packing, storage, or transport.

Because **real-world, continuous datasets for all these variables are scarce and often proprietary**, we generated **synthetic data** to represent realistic distributions of each parameter.

| Parameter          | Distribution Used               | Source / Calibration |
|--------------------|----------------------------------|----------------------|
| Storage Temperature | Truncated Gaussian              | Industry-reported ranges & literature |
| Initial Maturity    | Uniform (bounded by field surveys) | Florida maturity distribution data |
| Time Duration       | Uniform (half-day variation)    | Operational observations |

Synthetic datasets allowed us to **stress-test** the model with 1,000+ runs, exploring combinations of these uncertainties.

---

## 💡 Why Synthetic Data Matters
In agricultural supply chains, **data gaps are the norm**:
- Many variables are **proprietary** to commercial partners.
- Environmental and operational data are often **sparse** or **not collected continuously**.
- Some “what-if” scenarios (e.g., extreme delays, temperature spikes) **never occur in historical records** — but are crucial to test.

By generating **synthetic, distribution-based datasets**, we could:
- Reproduce realistic conditions **without exposing confidential partner data**.
- Explore **edge cases** beyond what historical data shows.
- Ensure **full reproducibility** — every simulation can be re-run exactly by sharing the random seed and generation code.
- Create a **scalable framework** that can adapt to other crops, geographies, or supply chains.

This approach bridges **academic modeling** and **data engineering best practices**, making the model robust, reusable, and transparent.

---

## 🛠 What’s Inside
- `CleanOpermodel.mod` – Base GAMS/AMPL optimization model.
- `OperMCordered.run` – Monte Carlo execution file.
- `COLtablegen` – Generates synthetic scenario tables.
- `input2.xlsx` – Seed data for stochastic draws.

---

## ⚙ How It Works
1. **Synthetic Data Generation**:  
   - `COLtablegen` creates randomized inputs for temperature, maturity, and time delay using the defined probability distributions.
   - Random seeds ensure reproducibility.
2. **Simulation Runs**:  
   - Each run solves the operational optimization model with a different set of uncertainty parameters.
3. **Evaluation Metrics**:
   - Mean and 95% CI for profit, PHL, and shipment quantities.
   - Sensitivity analysis for each uncertainty type and combinations.

---

## 📊 Key Results
- **PHL range across scenarios**: 380M – 445M lbs/year.
- **Impact ranking**:
  1. Combined temperature + maturity deviation had the largest effect on losses.
  2. Time delay alone had the smallest impact.
- **Hotspot stability**: Certain facilities had consistently high loss under all scenarios → prime targets for intervention.

---

## ▶ How to Run
# Requires GAMS installed
gams OperMCordered.run

Keep input2.xlsx and COLtablegen in the working directory.

📚 Citation
If using this model, please cite:

> Suthar, R.G. (2021). Modeling Postharvest Losses in the Florida Tomato System. PhD Dissertation, University of Florida. Chapter 3.
