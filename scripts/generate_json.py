# Python program to write JSON to a file

from random import randint
import pandas as pd
import itertools, string, json

data = pd.read_csv('train.csv')
data = data[data.url != "None"]
urls = data["url"].head(1500)
urls = urls.dropna().unique()


def _column_name_generator():
    for i in itertools.count(1):
        for p in itertools.product(string.ascii_uppercase, repeat=i):
            yield ''.join(p)
y = 0
letters = []
for x in _column_name_generator():
    if y == 1000:
        break
    letters.append(x)
    y += 1

# Descriptions of varying lengths
descriptions = [
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
]

json_data = []

for i in range(1000):
    d = {"productName": "Product " + letters[i], "productUrl": urls[i], "productRating": randint(0, 5),
         "productDescription": descriptions[randint(0, 2)]}
    json_data.append(d)

# Serializing json
json_object = json.dumps(json_data, indent=4)

# Writing to products.json
with open("products.json", "w") as outfile:
    outfile.write(json_object)