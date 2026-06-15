# 🛒 Sales Analysis: End-to-End BI Project

> An end-to-end Business Intelligence pipeline that transforms raw sales data into actionable insights — helping business owners and decision-makers understand **what's selling, who's buying, and where the money is going**.

---

## 📌 Project Overview

This project presents a complete Sales Analytics solution built on real transactional data covering **4 years (2021–2024)** across multiple markets in Saudi Arabia.

The goal is to help sales teams and management answer critical business questions such as:

- 📉 Are high discounts actually hurting our profit?
- 🌍 Which markets and provinces generate the most revenue?
- 🏆 Who are our most valuable customers — and are we retaining them?
- 📦 Which products drive the most profit?
- 🚚 Are we spending too much on shipping?
- 📅 When do sales peak — and can we predict it?

The project covers the complete analytics workflow — from raw data cleaning and transformation, to database modeling, SQL analysis, and interactive dashboard development.

---

## ❓ Business Questions

This project focuses on answering the following business questions:

1. How have total sales, profit, and orders grown year over year?
2. Do discounts increase revenue — or destroy profit margins?
3. Which markets and provinces lead in sales performance?
4. Which products are the most and least profitable?
5. Are we serving high-value customers or losing them after one purchase?
6. Which shipping mode balances cost and speed most effectively?
7. What seasonal patterns exist in sales and shipping costs?
8. How is profit distributed across customer segments?

---

## 🔄 Project Workflow

### 1️⃣ Data Cleaning & Preparation (Python)

The raw dataset contained several data quality issues including missing values, inconsistent data types, and incomplete records.
Cleaning and preprocessing were performed using **Python and Pandas**.

**Customers Table**

| Action | Detail |
|--------|--------|
| Merge name columns | First Name + Last Name → Customer Name |
| Create payment flag | Paid > 0 → "Paid" / "Not Paid" |
| Load to SQL | Customers_Data table |

**Orders Table**

| Action | Detail |
|--------|--------|
| Fix dtype | Shipping Cost → `pd.to_numeric(errors="coerce")` |
| Fill nulls | Shipping Cost → mean · Rating → median · Status → "Pending" |
| Extract category | Product ID[:3] → Category column |
| Avg rating per category | `groupby("Category")["Rating"].mean()` mapped to each row |
| Net Profit B | Profit - Shipping Cost |
| Net Profit A | Net Profit B × (1 - Discount) |
| Load to SQL | Orders_Data table |

---

### 2️⃣ Database Design (SQL Server)

After cleaning, the dataset was loaded into **SQL Server**.
A **Star Schema** model was designed to improve analytical performance and support reporting requirements.

**Fact Table**
- `OrdersCleaning`

**Dimension Tables**
- `Customers` · `Products` · `Markets`

Additionally, **10 SQL queries** were developed to answer key business questions.

| # | Question | Dashboard Page |
|---|----------|----------------|
| Q1 | Sales, profit & orders per year | Overview — KPIs |
| Q2 | Impact of discount level on profit | Overview — Discount Scatter |
| Q3 | Top markets by sales & profit | Overview — Top Province |
| Q4 | Top 10 products by profit | Products — Top Products |
| Q5 | High-price low-volume vs low-price high-volume | Products — Scatter |
| Q6 | Customer loyalty tiers (VIP / Loyal / Returning) | Customer — Retention |
| Q7 | Shipping mode — cost & lead time | Operations — Ship Mode |
| Q8 | Monthly shipping cost trend | Operations — Monthly Cost |
| Q9 | Sales & profit by category | Products — Category Chart |
| Q10 | Order status breakdown | Overview — Donut Chart |

---

### 3️⃣ Dashboard Development (Power BI)

An interactive dashboard was developed using **Power BI and DAX** with a clean purple theme and full navigation across 4 pages.

**Dashboard Pages**

**Sales Overview**
Provides a high-level view of business performance including:
- Total Sales (3.34M) · Orders (7K) · AOV (496.99) · Profit (403.40K)
- Year-over-year growth indicators
- Orders by status breakdown
- Top provinces by sales
- Effect of discount on profit
- Total sales trend over months and years
- Profit by market and customer segment

**Customer Insights**
Analyzes customer behavior and loyalty including:
- Total customers (1,443) · AVG sales per customer (2.32K)
- Repeat Purchase Rate (91.3%) · Retention Rate (96%)
- Customer distribution by nationality, market, and gender
- Top 10 customers by sales and orders
- New vs total customers trend by year

**Products Overview**
Focuses on product performance and profitability including:
- Sales vs Profit relationship scatter
- Total sales and profit by category
- Top products by profit — Canon imageCLASS 2200 leads with 9,520
- Quantity distribution by province (map visual)

**Operations & Shipping**
Evaluates logistics efficiency including:
- Total Shipping Cost (361.07K) · AVG Lead Time (3.98 days)
- Shipping cost and lead time by ship mode
- Monthly shipping cost trend
- Quantity and lead time by quarter

---

## 💡 Key Insights

**Discounts Are Hurting Profit**
Orders with 51%+ discounts result in negative net profit on average — meaning the business is losing money on heavily discounted sales.

**Mecca Leads All Markets**
Mecca generated 23,837 in sales — the highest among all provinces — followed by Eastern Province and Aseer.

**Exceptional Customer Retention**
With a 96% retention rate and 91.3% repeat purchase rate, the business has a highly loyal customer base worth protecting.

**Technology Dominates Profit**
The Technology category delivered the highest profit at 0.49M, making it the most valuable product line in the portfolio.

**Standard Class Is Popular but Slow**
Standard Class is the most used shipping mode but has the longest lead time at 5 days average — a potential area for optimization.

**Peak Season Is Q4**
November and December show a consistent spike in both sales and shipping costs across all years — indicating strong seasonal demand.

---

## 🛠️ Tools & Technologies

- **Python** — Data cleaning & feature engineering
- **Pandas** — Data manipulation
- **SQLAlchemy** — Loading data to SQL Server
- **SQL Server Express** — Database & analytical queries
- **Power BI Desktop** — Interactive dashboard
- **DAX** — Custom measures and KPIs
- **Star Schema Modeling** — Data warehouse design

---

## 🚀 How to Run

1. Open `Sales_ETL_Pipeline.ipynb` and update file paths + SQL connection string
2. Run all cells — data loads automatically to SQL Server
3. Run `Sales_SQL_Queries.sql` in SSMS against `Sales_Insights` database
4. Open the `.pbix` file in Power BI Desktop and refresh the data source

---

## 🗂️ Repository Structure

```
📦 Sales-Insights-BI/
├── 📓 Sales_ETL_Pipeline.ipynb                   ← Python cleaning & loading
├── 📄 Sales_SQL_Queries.sql                      ← 10 analytical SQL queries
├── 📊 Sales Analysis End-to-End BI Project.pbix  ← Power BI report
├── 🖼️ Images/                                    ← Dashboard screenshots
└── 📖 README.md
```

---

## 👤 Author
**Moaaz Areshy** — Data Analyst
(https://www.linkedin.com/in/moaaz-ali-36238b2aa/)
