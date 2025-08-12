# 🍅 Modeling Postharvest Tomato Losses in Florida’s Tomato Supply Chain

This repository showcases the computational work from my **PhD in Agricultural Data Science**, where I developed models to understand, simulate, and reduce **postharvest tomato losses** in Florida’s fresh-market tomato system.

The project blends **data engineering**, **mathematical optimization**, and **simulation** to tackle one big question:

The work integrates:
- **Operational Optimization** (mapping and improving supply chain flows)
- **Monte Carlo Simulation** (testing under uncertainty)
- **Robust Optimization** (designing strategies that work even in worst-case scenarios)

---

## 📂 Project Structure

| Chapter | Focus | Folder |
|---------|-------|--------|
| **2** | Baseline operational model of the Florida tomato supply chain | [Ch2-main](Ch2-main) |
| **3** | Monte Carlo simulations to test uncertainty impacts | [Ch3-main](Ch3-main) |
| **4** | Robust optimization to ensure resilience under worst-case conditions | [Ch4-main](Ch4-main) |

---

## 📊 Key Results

### **Baseline Findings (Chapter 2)**
- **Total annual postharvest losses:** ~**408 million lbs** of fresh-market tomatoes.
- **Loss hotspots:** Packinghouse → Distribution Center stage, followed by Distribution Center → Retail.
- **Optimization potential:** Up to **8% loss reduction** by reallocating supply chain flows without increasing costs.

### **Monte Carlo Simulation (Chapter 3)**
- Tested **1,000+ stochastic scenarios** for weather, handling, and demand variability.
- Losses ranged from **380M to 445M lbs/year** depending on scenario.
- Identified “persistent hotspots” — locations that remain high-loss under all conditions, making them strategic intervention points.

### **Robust Optimization (Chapter 4)**
- Strategies remained effective under worst-case scenarios, reducing losses by **6–7%** even during combined weather + market shocks.
- Balanced trade-offs between cost, resilience, and waste reduction.
- Python + GAMS integration allowed automated scenario table generation and rapid re-optimization.

---

## 🛠 Tech Stack
- **Modeling Languages:** GAMS, AMPL
- **Data Tools:** Python, Excel
- **Methods:** Linear programming, Monte Carlo simulation, robust optimization
- **Domains:** Agricultural supply chains, postharvest loss modeling, food systems

---

## 📈 Impact
This work provides:
- A **data-driven framework** for reducing postharvest losses in perishable supply chains.
- Transferable methods that can be applied to other crops and regions.
- Insights that bridge academic research with practical, on-the-ground decision making.

---

## 🚀 How to Explore
1. Clone this repo:
   ```bash
   git clone https://github.com/yourusername/tomato-loss-modeling.git
   cd tomato-loss-modeling
   ```
2.Follow the instructions in its README.md.

🖼 Florida Tomato Supply Chain (Conceptual)
[Farm] → [Packinghouse] → [Distribution Center] → [Retail] → [Consumer]
