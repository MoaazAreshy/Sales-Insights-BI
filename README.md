# 🛒 Sales Analysis Project

End-to-end analytics pipeline: **Python → SQL Server → Power BI**

---

## 🗂️ Repository Structure

```
📦 graduation-project/
├── 📓 Sales_ETL_Pipeline.ipynb    ← Python cleaning & loading
├── 📄 Sales_SQL_Queries.sql       ← 10 analytical SQL queries
├── 📊 Dashboard.pbix              ← Power BI report
└── 📖 README.md
```

---

## 🔄 Pipeline Stages

### 1️⃣ Python — Data Cleaning (`Sales_ETL_Pipeline.ipynb`)

**Customers Table**
| Action | Detail |
|--------|--------|
| Merge name columns | `First Name + Last Name` → `Customer Name` |
| Create payment flag | `Paid > 0` → `"Paid"` / `"Not Paid"` |
| Load to SQL | `Customers_Data` table |

**Orders Table**
| Action | Detail |
|--------|--------|
| Fix dtype | `Shipping Cost` → `pd.to_numeric(errors="coerce")` |
| Fill nulls | `Shipping Cost` → mean \| `Rating` → median \| `Status` → `"Pending"` |
| Extract category | `Product ID[:3]` → `Category` column |
| Avg rating per category | `groupby("Category")["Rating"].mean()` mapped to each row |
| Net Profit B | `Profit - Shipping Cost` |
| Net Profit A | `Net Profit B × (1 - Discount)` |
| Load to SQL | `Orders_Data` table |

---

### 2️⃣ SQL Server (`Sales_SQL_Queries.sql`)

| # | Question | Dashboard |
|---|----------|-----------|
| Q1 | Sales, profit & orders per year | Overview — KPIs |
| Q2 | Impact of discount level on profit | Overview — Discount scatter |
| Q3 | Top markets by sales & profit | Overview — Top Province |
| Q4 | Top 10 products by profit | Products — Top Products |
| Q5 | High-price low-volume vs low-price high-volume | Products — Scatter |
| Q6 | Customer loyalty tiers (VIP / Loyal / Returning) | Customer — Retention 96% |
| Q7 | Shipping mode — cost & lead time | Operations — Ship Mode |
| Q8 | Monthly shipping cost trend | Operations — Monthly Cost |
| Q9 | Sales & profit by category | Products — Category chart |
| Q10 | Order status breakdown | Overview — Donut chart |

---

### 3️⃣ Power BI — Star Schema

```
         ┌─────────────┐
         │   Markets   │
         └──────┬──────┘
                │
┌────────────┐  │  ┌──────────────────┐  ┌──────────┐
│  Customers ├──┼──┤  OrdersCleaning  ├──┤ Products │
│  (Dim)     │  │  │   (Fact Table)   │  │  (Dim)   │
└────────────┘  │  └──────────────────┘  └──────────┘
```

**Fact Table — `OrdersCleaning`**
`Order_ID` · `Order_Date` · `Ship_Date` · `Customer_ID` FK · `Market_ID` FK · `Product_ID` FK  
`Sales` · `Profit` · `Quantity` · `Discount` · `Shipping Cost` · `Ship_Mode` · `Status`  
`Rating` · `Avg_Rating_By_Category` · `Net Profit.B` · `Net Profit.A`

---

### 4️⃣ Dashboard — Key Findings

| Finding | Numbers |
|---------|---------|
| High discounts hurt profit | 51%+ discount → negative net profit on average |
| Top market | Mecca leads with 23,837 in sales |
| Customer loyalty | 91.3% repeat rate · 96% retention rate |
| Best category | Technology — highest profit (0.49M) |
| Top product | Canon imageCLASS 2200 (9,520 profit) |
| Preferred shipping | Standard Class — most used but slowest (5 days avg) |
| Peak season | November–December spike in sales & shipping cost |

---

## 🛠️ Tech Stack

`Python` · `pandas` · `SQLAlchemy` · `SQL Server Express` · `Power BI Desktop`

---

## 🚀 How to Run

1. Open `Sales_ETL_Pipeline.ipynb` and update file paths + SQL connection string
2. Run all cells — data loads automatically to SQL Server
3. Run `Sales_SQL_Queries.sql` in SSMS against `Sales_Insights` database
4. Open `Sales Analysis End-to-End BI Project.ipynb` in Power BI and refresh data source
