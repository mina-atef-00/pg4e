# https://www.pg4e.com/code/elasticbook.py

# Download a book
# wget http://www.gutenberg.org/cache/epub/18866/pg18866.txt
# wget http://www.gutenberg.org/cache/epub/14091/pg14091.txt
# wget https://www.gutenberg.org/files/2591/2591-0.txt
# wget https://www.gutenberg.org/files/11/11-0.txt

# (If needed)
# https://www.pg4e.com/code/hidden-dist.py
# copy hidden-dist.py to hidden.py
# edit hidden.py and put in your credentials

# python3 elasticbook.py

import copy
import hashlib
import json
import time
import uuid

import hidden
from elasticsearch import Elasticsearch

bookfile = "pg20203.txt"
indexname = bookfile.split(".")[0]

# Make sure we can open the file
fhand = open(bookfile)

# Load the secrets
secrets = hidden.elastic()

es: Elasticsearch = Elasticsearch(
    [secrets["host"]],
    http_auth=(secrets["user"], secrets["pass"]),
    url_prefix=secrets["prefix"],
    scheme=secrets["scheme"],
    port=secrets["port"],
)
indexname = secrets["user"]

# Start fresh
# https://elasticsearch-py.readthedocs.io/en/master/api.html#indices
res = es.indices.delete(index=indexname, ignore=[400, 404])
print("Dropped index", indexname)
print(res)

res = es.indices.create(index=indexname)
print("Created the index...")
print(res)

para = ""
chars = 0
count = 0
pcount = 0
for line in fhand:
    count = count + 1
    line = line.strip()
    chars = chars + len(line)
    if line == "" and para == "":
        continue
    if line == "":
        pcount = pcount + 1
        doc = {"offset": pcount, "content": para}

        m = hashlib.sha256()
        m.update(json.dumps(doc).encode())
        pkey = m.hexdigest()

        res = es.index(index=indexname, id=pkey, body=doc)

        print("Added document", pkey)
        # print(res['result'])

        if pcount % 100 == 0:
            print(pcount, "loaded...")
            time.sleep(1)

        para = ""
        continue

    para = para + " " + line

# Tell it to recompute the index
res = es.indices.refresh(index=indexname)
print("Index refreshed", indexname)
print(res)

print(" ")
print("Loaded", pcount, "paragraphs", count, "lines", chars, "characters")
