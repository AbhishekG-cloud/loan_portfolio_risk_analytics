SELECT
    'id' AS column_name,
    COUNT(*) FILTER (WHERE id IS NULL) AS missing_count,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE id IS NULL) / COUNT(*),
        4
    ) AS missing_percentage
FROM loans

UNION ALL

SELECT
    'issue_d',
    COUNT(*) FILTER (WHERE issue_d IS NULL OR TRIM(issue_d) = ''),
    ROUND(100.0 * COUNT(*) FILTER (
        WHERE issue_d IS NULL OR TRIM(issue_d) = ''
    ) / COUNT(*), 4)
FROM loans

UNION ALL

SELECT
    'loan_status',
    COUNT(*) FILTER (WHERE loan_status IS NULL OR TRIM(loan_status) = ''),
    ROUND(100.0 * COUNT(*) FILTER (
        WHERE loan_status IS NULL OR TRIM(loan_status) = ''
    ) / COUNT(*), 4)
FROM loans

UNION ALL

SELECT
    'loan_amnt',
    COUNT(*) FILTER (WHERE loan_amnt IS NULL),
    ROUND(100.0 * COUNT(*) FILTER (WHERE loan_amnt IS NULL) / COUNT(*), 4)
FROM loans

UNION ALL

SELECT
    'grade',
    COUNT(*) FILTER (WHERE grade IS NULL OR TRIM(grade) = ''),
    ROUND(100.0 * COUNT(*) FILTER (
        WHERE grade IS NULL OR TRIM(grade) = ''
    ) / COUNT(*), 4)
FROM loans

UNION ALL

SELECT
    'term',
    COUNT(*) FILTER (WHERE term IS NULL OR TRIM(term) = ''),
    ROUND(100.0 * COUNT(*) FILTER (
        WHERE term IS NULL OR TRIM(term) = ''
    ) / COUNT(*), 4)
FROM loans

UNION ALL

SELECT
    'purpose',
    COUNT(*) FILTER (WHERE purpose IS NULL OR TRIM(purpose) = ''),
    ROUND(100.0 * COUNT(*) FILTER (
        WHERE purpose IS NULL OR TRIM(purpose) = ''
    ) / COUNT(*), 4)
FROM loans

UNION ALL

SELECT
    'addr_state',
    COUNT(*) FILTER (WHERE addr_state IS NULL OR TRIM(addr_state) = ''),
    ROUND(100.0 * COUNT(*) FILTER (
        WHERE addr_state IS NULL OR TRIM(addr_state) = ''
    ) / COUNT(*), 4)
FROM loans;


------------------------

SELECT
    COUNT(*) AS total_records,
    COUNT(id) AS non_null_ids,
    COUNT(DISTINCT id) AS unique_ids,
    COUNT(*) FILTER (WHERE id IS NOT NULL)
        - COUNT(DISTINCT id) AS duplicate_records
FROM loans;

-------------------------------------
SELECT
    id,
    COUNT(*) AS occurrences
FROM loans
GROUP BY id
HAVING COUNT(*) > 1;
---------------------------------
WITH distinct_records AS (
    SELECT DISTINCT *
    FROM loans
),
record_versions AS (
    SELECT
        id,
        COUNT(*) AS distinct_record_versions
    FROM distinct_records
    GROUP BY id
),
id_counts AS (
    SELECT
        id,
        COUNT(*) AS occurrences
    FROM loans
    GROUP BY id
)
SELECT
    i.id,
    i.occurrences,
    v.distinct_record_versions
FROM id_counts i
JOIN record_versions v 
USING (id)
WHERE i.occurrences > 1;



---------------------------------------
SELECT
    MIN(loan_amnt) AS min_loan_amnt,
    MAX(loan_amnt) AS max_loan_amnt,
    COUNT(*) FILTER (
        WHERE loan_amnt <= 0
    ) AS non_positive_count,
    COUNT(*) FILTER (
        WHERE loan_amnt = 0
    ) AS zero_count
FROM loans;

---------------------------------------

SELECT
    typeof(int_rate) AS data_type,
    MIN(int_rate) AS min_interest_rate,
    MAX(int_rate) AS max_interest_rate,
    COUNT(*) FILTER (
        WHERE int_rate IS NULL
    ) AS null_count
FROM loans;

SELECT
    int_rate,
    COUNT(*) AS record_count
FROM loans
GROUP BY int_rate
ORDER BY int_rate;

---------------------------------------
SELECT
    grade,
    COUNT(*) AS record_count
FROM loans
GROUP BY grade
ORDER BY grade;

---------------------------------------
SELECT
    term,
    COUNT(*) AS record_count
FROM loans
GROUP BY term
ORDER BY term;

---------------------------------------

SELECT
    issue_d,
    COUNT(*) AS record_count,
    TRY_STRPTIME(issue_d, '%b-%y') AS parsed_issue_date
FROM loans
GROUP BY issue_d
ORDER BY parsed_issue_date;

SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (
        WHERE issue_d IS NULL
    ) AS null_dates,
    COUNT(*) FILTER (
        WHERE issue_d IS NOT NULL
        AND TRY_STRPTIME(issue_d, '%b-%y') IS NULL
    ) AS invalid_dates
FROM loans;
---------------------------------------

SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (
        WHERE loan_amnt > funded_amnt
    ) AS loan_greater_than_funded,
    COUNT(*) FILTER (
        WHERE loan_amnt < funded_amnt
    ) AS loan_less_than_funded,
    COUNT(*) FILTER (
        WHERE loan_amnt = funded_amnt
    ) AS equal_amounts
FROM loans;

---------------------------------------

SELECT
    COUNT(*) FILTER (WHERE loan_amnt < 0) AS negative_loan_amount,
    COUNT(*) FILTER (WHERE funded_amnt < 0) AS negative_funded_amount,
    COUNT(*) FILTER (WHERE installment < 0) AS negative_installment,
    COUNT(*) FILTER (WHERE int_rate < 0) AS negative_interest_rate
FROM loans;
---------------------------------------
SELECT
    COUNT(*) FILTER (WHERE loan_amnt < 0) AS negative_loan_amount,
    COUNT(*) FILTER (WHERE funded_amnt < 0) AS negative_funded_amount,
    COUNT(*) FILTER (WHERE installment < 0) AS negative_installment,
    COUNT(*) FILTER (WHERE int_rate < 0) AS negative_interest_rate
FROM loans;
---------------------------------------
SELECT
    MIN(installment) AS min_installment,
    MAX(installment) AS max_installment,
    AVG(installment) AS avg_installment,
    MEDIAN(installment) AS median_installment,
    QUANTILE_CONT(installment, 0.99) AS p99_installment
FROM loans;
---------------------------------------
SELECT
    id,
    loan_amnt,
    funded_amnt,
    term,
    int_rate,
    installment
FROM loans
ORDER BY installment DESC
LIMIT 20;
