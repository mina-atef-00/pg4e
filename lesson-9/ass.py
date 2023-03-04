import hidden
import psycopg
import requests

secrets = hidden.secrets()

conn = psycopg.connect(
    host=secrets["host"],
    port=secrets["port"],
    dbname=secrets["dbname"],
    user=secrets["user"],
    password=secrets["pass"],
    connect_timeout=3,
)

cur = conn.cursor()

defaulturl = "https://pokeapi.co/api/v2/pokemon-species/"
print("If you want to restart the spider, run")
print("DROP TABLE IF EXISTS pokeapi CASCADE;")
print(" ")

sql = """
CREATE TABLE IF NOT EXISTS pokeapi (id INTEGER, body JSONB);
"""
print(sql)
cur.execute(sql)

fail = 0
for num, url in ((num, f"{defaulturl}{num}") for num in range(1, 101)):
    text = "None"
    try:
        print("=== Url is", url)
        response = requests.get(url)
        text = response.text
        sql = "insert into pokeapi (id, body) values (%s,%s);"
        row = cur.execute(sql, (num, text))
    except KeyboardInterrupt:
        print("")
        print("Program interrupted by user...")
        break
    except Exception as e:
        print("Unable to retrieve or parse page", url)
        print("Error", e)
        fail = fail + 1
        if fail > 5:
            break
        continue

conn.commit()
