# 📊 Blinkit Sales Analysis Dashboard | Power BI Capstone Project

![Dashboard Preview](./images/Screenshot (59).png)

This Power BI Capstone Project presents a comprehensive analysis of sales data for **Blinkit – India's Last Minute App**, using real-world dataset exploration, data cleaning, and interactive visualization.

---

## 📌 Project Objective

The goal is to derive meaningful insights from Blinkit's sales data across multiple outlets, sizes, and item categories, and present it in an intuitive and interactive dashboard using **Power BI**.

---

## 🧱 Project Workflow

### 🔹 1. Data Collection & Import
- Original data file: [blinkit_sales_data.xlsx](./blinkit_sales_data.xlsx)
- Imported into **MySQL Workbench** for initial preprocessing.

### 🔹 2. Data Cleaning using SQL
- **Data Source**: Excel (.xlsx)
- Imported into MySQL Workbench
- Cleaned using SQL queries:
  - Removed inconsistencies
  - Standardized column values (e.g., `Item Fat Content`)
  - Filtered and transformed raw data for analysis

> ✅ Example SQL:
```sql
UPDATE blinkit_data
SET `Item Fat Content` = 
CASE 
    WHEN `Item Fat Content` IN ('LF', 'low fat') THEN 'Low Fat'
    WHEN `Item Fat Content` = 'reg' THEN 'Regular'
    ELSE `Item Fat Content`
END;
