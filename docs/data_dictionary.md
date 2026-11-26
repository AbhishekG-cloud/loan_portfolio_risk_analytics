
# Data Dictionary — Loan Portfolio Risk Analytics

## 1. Dataset Overview

| Attribute | Value |
|---|---|
| Dataset | Lending Club 2007–2011 |
| Database table | loans |
| Records | 39,717 |
| Columns | 111 |
| Unique loan IDs | 39,717 |
| Duplicate IDs | 0 |
| Origination period | June 2007 – December 2011 |
| Unique states | 50 |

## 2. Primary Identifier

| Column | Data Type | Business Meaning | Essential |
|---|---|---|---|
| id | BIGINT | Unique loan identifier | Yes |

## 3. Origination and Performance

| Column | Data Type | Business Meaning | Essential |
|---|---|---|---|
| issue_d | VARCHAR | Loan origination month | Yes |
| loan_status | VARCHAR | Current or final loan status | Yes |
| last_pymnt_d | VARCHAR | Date of last payment | Useful |
| next_pymnt_d | VARCHAR | Next scheduled payment date | No |

## 4. Financial Exposure and Repayment

| Column | Data Type | Business Meaning | Essential |
|---|---|---|---|
| loan_amnt | BIGINT | Original loan amount requested | Yes |
| funded_amnt | BIGINT | Amount funded to borrower | Yes |
| funded_amnt_inv | DOUBLE | Amount funded by investors | Useful |
| installment | DOUBLE | Monthly payment amount | Useful |
| total_pymnt | DOUBLE | Total payments received | Yes |
| total_rec_prncp | DOUBLE | Principal received | Useful |
| total_rec_int | DOUBLE | Interest received | Useful |
| recoveries | DOUBLE | Amount recovered after charge-off | Yes |
| out_prncp | DOUBLE | Outstanding principal | Yes |
| total_rec_late_fee | DOUBLE | Late fees received | Useful |

## 5. Loan Risk Segmentation

| Column | Data Type | Business Meaning | Essential |
|---|---|---|---|
| grade | VARCHAR | Lending Club assigned loan grade | Yes |
| sub_grade | VARCHAR | More granular credit grade | Useful |
| term | VARCHAR | Loan repayment duration | Yes |
| purpose | VARCHAR | Stated purpose of loan | Yes |

## 6. Borrower Characteristics

| Column | Data Type | Business Meaning | Essential |
|---|---|---|---|
| annual_inc | DOUBLE | Annual borrower income | Useful |
| dti | DOUBLE | Debt-to-income ratio | Useful |
| emp_length | VARCHAR | Employment length | Useful |
| home_ownership | VARCHAR | Borrower's home ownership status | Useful |
| verification_status | VARCHAR | Income verification status | Useful |

## 7. Geographic Information

| Column | Data Type | Business Meaning | Essential |
|---|---|---|---|
| addr_state | VARCHAR | Borrower's state | Yes |
| zip_code | VARCHAR | Partially masked ZIP code | No |

## 8. Data Quality Findings

- 39,717 records.
- 39,717 unique loan IDs.
- No duplicate IDs found.
- No missing values in the 12 initially checked
  analytical columns.
- Origination dates span June 2007 to December 2011.
- Loan status contains Fully Paid, Charged Off and Current.

## 9. Analytical Limitations

### Default Definition

Charged Off is the observed default outcome.

Fully Paid represents completed loans.

Current represents loans without a final repayment outcome.

### Vintage Analysis

Origination month and loan outcome are available.
Vintage analysis is feasible, but loan maturity and
right-censoring must be considered.

### Roll-Rate Analysis

The dataset contains one record per loan rather
than repeated monthly delinquency observations.

Genuine monthly delinquency transitions cannot
be calculated from this dataset.

## 10. Preliminary Schema Decision

Use one loan-level table named `loans`.

No additional relational tables are required for
the initial portfolio analytics scope.
