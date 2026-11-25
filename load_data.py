
import duckdb


con = duckdb.connect("loan_portfolio.duckdb")


con.execute("""
    CREATE OR REPLACE TABLE loans AS
    SELECT *
    FROM read_csv_auto(
        'data/loan.csv',
        nullstr='NA'
    )
""")

result = con.execute("""
    SELECT COUNT(*) FROM loans;
""").fetchone()

print("Total loan records:", result[0])


print(con.execute("""
    SELECT * FROM loans LIMIT 5;
""").df())

con.close()
