# 🛒 Superstore Sales Analysis
### SQL + Power BI Dashboard Project

![Dashboard](Dashboard%20screenshot%20(PNG).png)

---

## 📌 Project Overview

This project performs an end-to-end analysis of a US retail superstore's sales data (2014–2017) using **MySQL** for data analysis and **Power BI** for interactive dashboard visualization.

The goal was to uncover actionable business insights around revenue, profitability, customer behavior, and regional performance to support data-driven decision-making.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| MySQL | Data storage, querying, and analysis |
| Power BI | Interactive dashboard and visualization |
| Excel/CSV | Data export and transformation |

---

## 📂 Dataset

- **Source:** [Superstore Dataset - Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
- **Rows:** 9,994 transactions
- **Period:** 2014 – 2017
- **Columns:** Order ID, Customer, Region, Category, Sales, Profit, Discount, Ship Mode, and more

---

## 🔍 Data Quality Checks

Before analysis, the following checks were performed in SQL:

| Check | Result |
|-------|--------|
| Total Rows | 9,994 ✅ |
| Duplicate Rows | 0 ✅ |
| NULL Values | 0 ✅ |
| Date Format | Clean ✅ |

**Conclusion:** Dataset was clean — no preprocessing required.

---

## 📊 SQL Analysis — 10 Business Questions

### Query 1: Revenue by Category
**Finding:** Technology leads with $835K revenue and 17.39% profit margin. Furniture despite $733K in sales has only 2.32% margin — indicating heavy discounting or high costs.

### Query 2: Monthly Sales Trend (2014–2017)
**Finding:** Sales show consistent year-over-year growth. Q4 (Oct–Dec) is always the strongest quarter. November 2017 recorded the highest monthly sales of $117K. January consistently drops after the holiday peak.

### Query 3: Top 10 Most Profitable Products
**Finding:** Canon imageCLASS 2200 Copier is the most profitable product at $25K profit with 40.91% margin. Copiers dominate the top 3 — making it the most profitable sub-category.

### Query 4: Regional Discount Impact
**Finding:** Central region gives the highest average discount (23.85%) and has the lowest profit ($40K). West region gives the least discount (11%) and generates the highest profit ($106K). Clear correlation: more discount = less profit.

### Query 5: Best and Worst Sub-Categories
**Finding:** Copiers (37.2% margin) and Labels (44.42% margin) are the top performers. Tables (-$17.7K), Bookcases (-$3.4K), and Supplies (-$1.3K) are operating at a loss.

### Query 6: Customer Segmentation by Revenue
**Finding:** High-value customers (spending $10K+) are not always profitable. Sean Miller spends the most ($25K) but generates a loss — indicating excessive discounting for certain customers.

### Query 7: Shipping Mode Analysis
**Finding:** Standard Class handles 60% of all orders and generates the highest profit ($161K). Same Day shipping is underutilized (259 orders only) — customers prefer cost over speed.

### Query 8: Top 10 Customers by Revenue (RANK)
**Finding:** Tamara Chand is the most valuable customer — $18K revenue with $8.7K profit. Sean Miller ranks #1 by revenue but generates a loss of $1.7K.

### Query 9: Month over Month Sales Growth (CTE + LAG)
**Finding:** March 2014 showed the highest growth (+1247%). January consistently drops every year (-54% to -75%) after December peak. Seasonal pattern is predictable and repeats every year.

### Query 10: Profit Margin by Category and Region
**Finding:** West + Office Supplies is the best combination (24% margin). Central + Furniture is the worst (-1.59% margin — losing money). Furniture underperforms in every single region.

---

## 📈 Power BI Dashboard

The interactive dashboard includes:

- **KPI Cards** — Total Revenue (2.27M), Total Profit (282.86K), Total Orders (8,918)
- **Revenue by Category** — Horizontal bar chart
- **Monthly Sales Trend** — Multi-year line chart (2014–2017)
- **Profit Margin by Region & Category** — Grouped column chart
- **Profit by Sub-Category** — Sorted bar chart showing negative profits
- **Top 10 Customers Table** — With conditional formatting for negative profits

> 📥 Download `Superstore_Dashboard.pbix` to explore the interactive dashboard in Power BI Desktop

---

## 💡 Key Business Recommendations

1. **Review Furniture pricing** — Tables, Bookcases, and Supplies are loss-making sub-categories
2. **Cap discounts in Central region** — 23.85% average discount is killing profitability
3. **Focus on Copiers and Technology** — Highest margins and consistent profit generators
4. **Investigate unprofitable high-revenue customers** — Sean Miller and Becky Martin spend a lot but generate losses
5. **Leverage Q4 seasonality** — Sales peak every Q4; plan inventory and marketing accordingly

---

## 🚀 How to Run This Project

1. Download `Sample - Superstore Data.csv`
2. Import into MySQL as `superstore` table
3. Run `superstore analysis.sql` to execute all 10 queries
4. Open `Superstore_Dashboard.pbix` in Power BI Desktop to explore the dashboard

---

## 👩‍💻 Author

**Prajakta Gawade**
Data Analyst | SQL • Power BI • Python

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://www.linkedin.com/in/prajakta-gawade-5399a8250)

