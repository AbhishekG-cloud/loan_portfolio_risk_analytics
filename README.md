# Loan Portfolio Risk Analytics

## Project Overview

A SQL-based financial analytics project focused on evaluating loan portfolio performance, identifying risk patterns, and analysing historical loan outcomes using Lending Club data.

The project uses SQL to investigate portfolio composition, repayment performance, default outcomes, and risk segmentation across different borrower and loan characteristics.

## Technology Stack

- **Database:** DuckDB
- **Query Language:** SQL
- **Programming:** Python (database setup and data loading)
- **Development Environment:** VS Code
- **Version Control:** Git and GitHub

## Dataset

**Source:** [Lending Club Loan Dataset 2007–2011 — Kaggle](https://www.kaggle.com/datasets/imsparsh/lending-club-loan-dataset-2007-2011)

| Attribute | Details |
|---|---|
| Total loan records | 39,717 |
| Total columns | 111 |
| Unique loan IDs | 39,717 |
| Origination period | June 2007 – December 2011 |
| Loan grades | A–G |
| Geographic coverage | 50 states |

### Loan Status Distribution

| Loan Status | Loan Count |
|---|---:|
| Fully Paid | 32,950 |
| Charged Off | 5,627 |
| Current | 1,140 |

## Project Objectives

The project aims to investigate:

1. Loan portfolio composition and segmentation.
2. Default and charge-off patterns.
3. Vintage-based loan performance.
4. Risk distribution across loan grades, purposes, and geographic regions.
5. Portfolio exposure, repayments, and recoveries.
6. Historical changes in portfolio performance.

## Planned SQL Analysis

- Data quality and validation checks
- Portfolio segmentation
- Default rate analysis
- Vintage analysis
- Top-N risky segments by state
- Rolling three-month default trends
- Portfolio exposure and recovery analysis

**Note:** Roll-rate analysis requires repeated monthly delinquency observations. The current dataset contains one record per loan, so genuine monthly delinquency transitions cannot be calculated. This analysis will not be fabricated.

## Repository Structure

```text
loan-portfolio-risk-analytics/
│
├── data/
│   └── loan.csv
│
├── sql/
│   └── 01_data_exploration.sql
│
├── docs/
│   └── data_dictionary.md
│
├── load_data.py
├── run_sql.py
├── loan_portfolio.duckdb
└── README.md
```



## Analytical Considerations

- Charged Off is treated as the observed default outcome in this dataset.
- Fully Paid loans represent completed repayment outcomes.
- Current loans are treated separately from resolved loans.
- Vintage analysis will account for differences in loan maturity.
- The original imported dataset will be preserved before any cleaning or transformation.

---


