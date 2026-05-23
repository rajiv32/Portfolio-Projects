# 💳 Credit Card Financial Dashboard — Power BI

An end-to-end Power BI project analyzing credit card transaction and customer data to surface revenue trends, customer segments, and spend behavior across multiple dimensions.

---

## 📊 Project Overview

This project consists of **two interconnected Power BI report pages**:

| Report | Description |
|---|---|
| **Credit Card Transaction Report** | Tracks revenue, interest, transaction volume, and spend patterns by card type, expense type, job, and education |
| **Credit Card Customer Report** | Profiles customers by age, income, marital status, geography, and job to understand revenue contribution |

---

## 🖼️ Dashboard Preview

### Transaction Report
![Transaction Report]<img width="1297" height="725" alt="image" src="https://github.com/user-attachments/assets/51c42ac4-6e19-4ae4-9752-20ec1bfd27ea" />


### Customer Report
![Customer Report]
<img width="1338" height="731" alt="image" src="https://github.com/user-attachments/assets/c8540377-c0a0-4e84-88b3-23ba1eef9bd7" />


---

## 🔑 Key Metrics (Overall)

| Metric | Value |
|---|---|
| Total Revenue | ₹55M |
| Interest Earned | ₹8M |
| Total Transaction Amount | ₹44.5M |
| Total Transaction Count | 656K |
| Total Customer Income | ₹576M |
| Customer Satisfaction Score (CSS) | 3.19 |

---

## 📌 Dashboard Highlights

### Transaction Report
- **Revenue by Quarter** — Q3 leads with ₹14.2M; trend line overlaid with transaction volume
- **Revenue by Use Type** — Swipe dominates at ₹35M, followed by Chip (₹17M) and Online (₹3M)
- **Revenue by Card Category** — Blue cards account for ₹46M out of ₹55M total
- **Revenue by Expense Type** — Bills (₹14M) and Entertainment (₹10M) are the top spend categories
- **Revenue by Job Type** — Businessmen contribute the highest at ₹17M
- **Revenue by Education** — Graduate cardholders drive ₹22M in revenue

### Customer Report
- **Revenue by Age Group** — The 40–60 age band is the highest-value segment
- **Revenue by Income Group** — High-income customers lead with ₹20M; surprisingly, low-income customers also contribute ₹10M
- **Revenue by State** — TX, NY, and CA are the top three states
- **Revenue by Marital Status** — Married customers generate slightly more revenue (₹15M vs ₹12M)
- **Revenue by Gender** — Male customers contribute ₹30M vs Female ₹25M

---

## 🛠️ Tools & Tech Stack

| Tool | Usage |
|---|---|
| **Power BI Desktop** | Report building, DAX measures, data modeling |
| **Power Query (M)** | Data transformation and cleaning |
| **DAX** | Revenue KPIs, time intelligence, calculated columns |
| **Excel / CSV** | Source data |

---

## 📁 Project Structure

```
Credit-Card-Financial-Dashboard/
│
├── CreditCard_Dashboard.pbix       # Main Power BI file
├── README.md                       # Project documentation
│
├── data/
│   ├── credit_card.csv             # Transaction-level data
│   └── customer.csv                # Customer demographic data
│
└── screenshots/
    ├── transaction_report.png
    └── customer_report.png
```

---

## 🧠 DAX Measures Used

```dax
-- Week number categorization
Week_Num = WEEKNUM('public cc_detail'[week_start_date])

-- Current week revenue
Current_week_Revenue = 
CALCULATE(
    SUM('public cc_detail'[Revenue]),
    FILTER(ALL('public cc_detail'), 'public cc_detail'[Week_Num] = MAX('public cc_detail'[Week_Num]))
)

-- Previous week revenue
Previous_week_Revenue = 
CALCULATE(
    SUM('public cc_detail'[Revenue]),
    FILTER(ALL('public cc_detail'), 'public cc_detail'[Week_Num] = MAX('public cc_detail'[Week_Num]) - 1)
)

-- Revenue field
Revenue = 'public cc_detail'[annual_fees] + 'public cc_detail'[total_trans_amt] + 'public cc_detail'[interest_earned]
```

---

## 💡 Key Insights

1. **Blue cardholders** are the highest revenue contributors by a wide margin (₹46M of ₹55M total)
2. **Swipe transactions** are the dominant payment method — an area to watch as digital payments grow
3. **Businessmen and graduates** are the most valuable customer segments
4. Revenue peaks in **Q3** and is consistent across Q1–Q2; Q4 shows a slight dip
5. **40–50 age group** drives the bulk of revenue — both income and spending align here
6. **TX, NY, and CA** together account for a major share of state-level revenue

---

## 🚀 How to Run

1. Clone or download this repository
2. Open `CreditCard_Dashboard.pbix` in **Power BI Desktop**
3. If using local CSV files, update the data source path in **Transform Data → Data Source Settings**
4. Refresh the data and explore using the slicers (Quarter, Week, Gender, Card Type, Use Type)

---

## 🙋 About

**Built by:** Rajiv  
**Role:** Data Analyst  
**Tools:** Power BI, DAX, Power Query  
**GitHub:** [github.com/rajiv32](https://github.com/rajiv32)  
**LinkedIn:** www.linkedin.com/in/rajiv-mallick-81495213a

---

> ⭐ If you found this project useful, consider giving it a star on GitHub!
