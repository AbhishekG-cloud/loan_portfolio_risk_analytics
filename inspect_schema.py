import duckdb
con = duckdb.connect("loan_portfolio.duckdb")
schema = con.execute("""
DESCRIBE loans
""").df()
print(schema.to_string(index=False))
con.close()