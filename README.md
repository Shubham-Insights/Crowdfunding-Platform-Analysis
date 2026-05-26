# 📊 Crowdfunding Platform Analysis — SQL + Tableau

An end-to-end data analysis project on 364,378 Kickstarter campaigns spanning 2009–2019.  
Built to uncover what drives campaign success — and what killed it in early 2019.

---

## 🔍 Project Overview   

| Item | Detail |
|---|---|
| Dataset | Kickstarter Campaigns (364,378 rows) |
| Tools | MySQL, Tableau |
| Tables | `project_1`, `category`, `creator`, `location`, `date` |
| Dashboards | 3 (Platform Overview, Funding Intelligence, Engagement & Goal Strategy) |

---

## 📁 Repository Structure

```
crowdfunding-analysis/
│
├── dataset/
│   └── crowdfunding_data.csv          # Raw Kickstarter dataset
│
├── sql/
│   └── crowdfunding_analysis.sql      # All queries with comments
│
├── tableau/
│   └── crowdfunding_dashboard.twbx    # Tableau packaged workbook
│
├── screenshots/
│   ├── dashboard_1_platform.png
│   ├── dashboard_2_category.png
│   └── dashboard_3_engagement.png
│
└── README.md
```

---

## 🗄️ Database Schema

The project uses a **star schema** with `project_1` as the fact table:

- **project_1** — core campaign data (id, state, usd_pledged, backers_count, goal, dates)
- (📂 Sample dataset included (1000 rows). Full dataset available on Kaggle — search "Kickstarter Campaigns".
- **category** — campaign category lookup
- **creator** — campaign creator details
- **location** — geographic data
- **date** — date dimension table (year, month, quarter)

Foreign keys and indexes created on `creator_id`, `location_id`, `category_id`, `created_date`.

---

## 🧠 SQL Analysis — Key Questions Answered

### 1. Platform-Level KPIs
- Total projects, total amount raised, overall success rate
- Total backers across all campaigns
- Average campaign duration for successful projects

### 2. Project Distribution
- Projects by **outcome** (successful, failed, canceled, suspended, purged)
- Projects by **country** (Top 10)
- Projects by **category** (Top 10)
- Projects by **year**, **quarter**, **month**

### 3. Success Rate Analysis
- Success % by **category** (min. 50 projects)
- Success % by **year + month** ← *anomaly detected here*
- Success % by **goal range**

### 4. Top Performers
- Top projects by **amount raised**
- Top projects by **backer count** (using `RANK()` window function)
- Category-wise funding totals

---

## 🔑 Key SQL Technique — Conditional Aggregation

Instead of using a subquery or CASE WHEN, success rate is calculated inline:

```sql
ROUND(
    SUM(state = 'successful') * 100.0 / COUNT(*),
2) AS success_percentage
```

MySQL evaluates boolean expressions as 1/0, making this a clean single-pass aggregation.

---

## 📈 Key Findings

### 🚨 The January 2019 Anomaly
| Month | Total Projects | Success Rate |
|---|---|---|
| March 2018 | — | **52.97%** (highest) |
| Most months | — | 35–45% |
| **January 2019** | **2,987** | **4.69%** (lowest) |

This is not a data quality issue — 2,987 projects is a large sample.  
The platform's **engagement index dropped from 98.1 (2018) to 52.3 (2020)**, suggesting backer participation began collapsing in early 2019, leaving thousands of campaigns without the audience needed to succeed.

### 📦 Goal Size vs Success
Smaller goals win more often:
| Goal Range | Success Rate |
|---|---|
| $0 – $10K | 57.63% |
| $10K – $50K | 55.34% |
| $50K – $100K | 49.38% |
| $100K+ | 35.19% |

### 🏆 Platform Summary
- **$3.85B** total raised across all campaigns
- **38.35%** overall success rate
- **44.47M** total backers
- **$1.52T** total goal amount set by creators

---

## 📊 Tableau Dashboards

### Dashboard 1 — Platform Performance Overview
- Funding & success rate trend (2009–2019)
- Outcome distribution (donut chart)
- Top 10 projects by funding raised
- Yearly funding efficiency trend

### Dashboard 2 — Funding Intelligence by Category
- Category contribution (treemap)
- Category vs outcome heatmap
- Category funding (Pareto-style bar)
- Category outcome distribution

### Dashboard 3 — Engagement & Goal Strategy Analysis
- Year-over-year engagement trend
- Year-wise success rate
- Backers vs funding raised (scatter)
- Distribution of project funding
- Goal size vs success rate

---

## ⚙️ How to Run

1. Import `dataset/crowdfunding_data.csv` into MySQL
2. Run `sql/crowdfunding_analysis.sql` (schema setup at top, queries below)
3. Open `tableau/crowdfunding_dashboard.twbx` in Tableau Desktop or Tableau Public

---

## 👤 Author

**Shubham Bagadade**  
Data Analyst | MCA — IICC Nagpur  
[Portfolio](https://shubham-insights.github.io) • [GitHub](https://github.com/Shubham-Insights) • [LinkedIn](https://linkedin.com/in/shubham-bagadade)
