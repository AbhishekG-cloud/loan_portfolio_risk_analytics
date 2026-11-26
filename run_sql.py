
import duckdb

con = duckdb.connect("loan_portfolio.duckdb")

with open("sql/01_data_exploration.sql", "r") as file:
    sql_script = file.read()

# Execute and display every SQL statement separately
statements = [
    statement.strip()
    for statement in sql_script.split(";")
    if statement.strip()
]

for i, statement in enumerate(statements, start=1):
    print(f"\n{'=' * 60}")
    print(f"QUERY {i}")
    print("=" * 60)

    try:
        result = con.execute(statement).df()
        print(result.to_string(index=False))
    except Exception as error:
        print("ERROR:", error)
        break

con.close()
