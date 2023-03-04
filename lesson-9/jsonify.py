import json
from typing import Any

data: dict[Any, Any] = {}
data["name"] = "Chuck"
data["phone"] = {}
data["phone"]["type"] = "intl"
data["phone"]["number"] = "+1 734 303 4456"
data["email"] = {}
data["email"]["hide"] = "yes"

# ? Serialize
print(json.dumps(data, indent=4))

# ? Produces the following output:
data1: str = """
{
    "name": "Chuck",
    "phone": {
        "type": "intl",
        "number": "+1 734 303 4456"
    },
    "email": {
        "hide": "yes"
    }
}
"""
info: dict = json.loads(data1)
print("Name:", info["name"])
print("Hide:", info["email"]["hide"])
