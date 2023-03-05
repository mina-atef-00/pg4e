# Keep this file separate

# https://www.pg4e.com/code/hidden-dist.py

# psql -h pg.pg4e.com -p 5432 -U pg4e_be9e729093 pg4e_be9e729093

import os

# %load_ext sql
# %config SqlMagic.autocommit=False
# %sql SELECT 1 as "Test"
import dotenv

print(dotenv.load_dotenv(".env"))


def secrets():
    return {
        "host": os.getenv("db_host"),
        "port": os.getenv("db_port"),
        "dbname": os.getenv("db_dbname"),
        "user": os.getenv("db_user"),
        "pass": os.getenv("db_pass"),
    }


def elastic():
    return {
        "host": os.getenv("host"),
        "prefix": os.getenv("prefix"),
        "port": os.getenv("port"),
        "scheme": os.getenv("scheme"),
        "user": os.getenv("user"),
        "pass": os.getenv("pass"),
    }
