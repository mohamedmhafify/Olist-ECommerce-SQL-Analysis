# 🛒 Olist E-Commerce SQL Analysis

## 📌 Project Overview
End-to-End SQL Business Intelligence Report on the 
**Olist Brazilian E-Commerce Public Dataset** (Kaggle).

Built as part of the **NTI Creativa Data Analytics Diploma**
at Cairo University Hub | June 2026.

---

## 🗄️ Database Architecture
- **9 Relational Tables** designed and imported from scratch
- Full **ERD** with Primary Keys & Foreign Keys
- Tool: **SQL Server Management Studio (SSMS 22)**

---

## 📊 Analysis Covers (16 SQL Queries)

| # | Analysis | SQL Concepts Used |
|---|----------|-------------------|
| 1 | Annual & Quarterly Sales Performance | CASE WHEN, GROUP BY, YEAR(), DATEPART() |
| 2 | Top & Bottom Selling Products | JOIN, GROUP BY, ORDER BY |
| 3 | Top & Bottom Rated Products | AVG(), HAVING, Multiple JOINs |
| 4 | Top & Bottom Regions by Orders | JOIN, GROUP BY |
| 5 | Most Popular Payment Methods | GROUP BY, Aggregations |
| 6 | Installment vs Full Payment Analysis | CASE WHEN, COUNT DISTINCT |
| 7 | Top & Bottom Sellers by Revenue | JOIN, GROUP BY |
| 8 | Top & Bottom Rated Sellers | COUNT DISTINCT, AVG, HAVING |
| 9 | Most Loyal Customers | COUNT DISTINCT, GROUP BY |
| 10 | Global Average Order Value (AOV) | Aggregations |
| 11 | Per-Customer Average Order Value | GROUP BY, Division |
| 12 | Basket Size Distribution | CTE, Window Function, CASE WHEN |
| 13 | Top Product per Region | CTE, RANK() OVER (PARTITION BY) |
| 14 | Market Basket Analysis (Cross-Selling) | Self JOIN, HAVING |
| 15 | Order Delivery Duration Analysis | DATEDIFF(), Filtering |
| 16 | Average Delivery Days per Seller | AVG(), Multiple JOINs |

---

## 🔑 Key Business Insights

- 💰 **$13.2M** Total Revenue | **96.4K** Delivered Orders
- 💳 **Credit Card** dominates **73.9%** of transactions
- 🛍️ **90%** of customers buy only **1 item** per order → Cross-Selling opportunity
- 🚚 Max delivery delay reached **210 days** → Critical Supply Chain issue
- 📍 **São Paulo (SP)** generates **38%** of total revenue

---

## 🛠️ Tools & Technologies

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-blue?style=flat)
![SSMS](https://img.shields.io/badge/SSMS%2022-red?style=flat)

---

## 📁 Files

| File | Description |
|------|-------------|
| `Olist_SQL_Analysis.sql` | All 16 SQL Queries with Arabic comments |
| `OLIST_Report.pdf` | Full BI Report with Visualizations |

---

## 👤 Author

**Mohamed Mostafa Hassan Afify**
- 📧 mohamedmhafify@gmail.com
- 💼 [LinkedIn](https://linkedin.com/in/mohamedmhafify)

---

⭐ If you found this useful, please star the repository!
