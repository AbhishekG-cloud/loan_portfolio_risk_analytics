
import duckdb

con = duckdb.connect("loan_portfolio.duckdb")

with open("sql/01_data_exploration.sql", "r") as file:
    query = file.read()

result = con.execute(query).df()

print(result)

con.close()
