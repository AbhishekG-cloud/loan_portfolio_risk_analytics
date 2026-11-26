
-- Overall dataset dimensions

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT id) AS unique_loans,
    COUNT(*) - COUNT(DISTINCT id) AS duplicate_or_null_id_difference
FROM loans;


-- Duplicate loan identifiers

SELECT
    id,
    COUNT(*) AS occurrences
FROM loans
GROUP BY id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;


-- Missing values in  columns

SELECT 'id' AS column_name, COUNT(*) FILTER (WHERE id IS NULL) AS missing_values FROM loans
UNION ALL
SELECT 'issue_d', COUNT(*) FILTER (WHERE issue_d IS NULL) FROM loans
UNION ALL
SELECT 'loan_status', COUNT(*) FILTER (WHERE loan_status IS NULL) FROM loans
UNION ALL
SELECT 'loan_amnt', COUNT(*) FILTER (WHERE loan_amnt IS NULL) FROM loans
UNION ALL
SELECT 'funded_amnt', COUNT(*) FILTER (WHERE funded_amnt IS NULL) FROM loans
UNION ALL
SELECT 'grade', COUNT(*) FILTER (WHERE grade IS NULL) FROM loans
UNION ALL
SELECT 'term', COUNT(*) FILTER (WHERE term IS NULL) FROM loans
UNION ALL
SELECT 'purpose', COUNT(*) FILTER (WHERE purpose IS NULL) FROM loans
UNION ALL
SELECT 'addr_state', COUNT(*) FILTER (WHERE addr_state IS NULL) FROM loans
UNION ALL
SELECT 'total_pymnt', COUNT(*) FILTER (WHERE total_pymnt IS NULL) FROM loans
UNION ALL
SELECT 'recoveries', COUNT(*) FILTER (WHERE recoveries IS NULL) FROM loans
UNION ALL
SELECT 'out_prncp', COUNT(*) FILTER (WHERE out_prncp IS NULL) FROM loans
ORDER BY column_name;


-- Loan distribution

SELECT
    loan_status,
    COUNT(*) AS loan_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM loans
GROUP BY loan_status
ORDER BY loan_count DESC;


-- Loan grade distribution

SELECT
    grade,
    COUNT(*) AS loan_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM loans
GROUP BY grade
ORDER BY grade;


-- Loan term distribution

SELECT
    term,
    COUNT(*) AS loan_count
FROM loans
GROUP BY term
ORDER BY term;


-- Loan purpose distribution

SELECT
    purpose,
    COUNT(*) AS loan_count
FROM loans
GROUP BY purpose
ORDER BY loan_count DESC;


-- Origination date range

SELECT
    MIN(STRPTIME(issue_d, '%b-%y')) AS earliest_issue_date,
    MAX(STRPTIME(issue_d, '%b-%y')) AS latest_issue_date,
    COUNT(DISTINCT issue_d) AS distinct_origination_months
FROM loans;


-- Geographic coverage

SELECT
    COUNT(DISTINCT addr_state) AS unique_states
FROM loans;


-- Loan performance date coverage

SELECT
    MIN(TRY_STRPTIME(NULLIF(TRIM(last_pymnt_d), ''), '%b-%y')) AS earliest_last_payment,
    MAX(TRY_STRPTIME(NULLIF(TRIM(last_pymnt_d), ''), '%b-%y')) AS latest_last_payment
FROM loans
WHERE last_pymnt_d IS NOT NULL;


--  Current loan exposure

SELECT
    COUNT(*) AS current_loan_count,
    SUM(out_prncp) AS outstanding_principal
FROM loans
WHERE loan_status = 'Current';
