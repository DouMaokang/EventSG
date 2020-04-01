import geojson
import random
import requests

path_to_file = "community-clubs-geojson.geojson"

govert_user_id = "277d24a0-6a05-41a1-aa4b-7cf749e8603d"

with open(path_to_file) as f:
    gj = geojson.load(f)
features = gj['features']

venue_dict = [{"address":"", "postalCode":0,"ownerId":govert_user_id, "rentalFee": 50.0 + random.randint(1, 10)*10, "area":100.0 + random.randint(1, 20)*10, "description":"", "venueName":""} for i in range(len(features))]

corrupted_dict_index = set()

description = features[86]["properties"]['Description']

postal_code_raw = description[description.find("ADDRESSPOSTALCODE"):]
postal_code = postal_code_raw[postal_code_raw.find("<td>")+4:postal_code_raw.find("</td>")]


for index,item in enumerate(features):
    description = item["properties"]['Description']

    addr_building_raw = description[description.find("ADDRESSBUILDINGNAME"):]
    addr_building = addr_building_raw[addr_building_raw.find("<td>")+4:addr_building_raw.find("</td>")]

    addr_street_raw = description[description.find("ADDRESSSTREETNAME"):]
    addr_street = addr_street_raw[addr_street_raw.find("<td>")+4:addr_street_raw.find("</td>")]

    address = addr_building + ' ' + addr_street

    postal_code_raw = description[description.find("ADDRESSPOSTALCODE"):]
    postal_code = postal_code_raw[postal_code_raw.find("<td>")+4:postal_code_raw.find("</td>")]
    if postal_code == "" or postal_code[0] == '0' or len(postal_code) != 6:
        corrupted_dict_index.add(index)

    venue_description_raw = description[description.find("DESCRIPTION"):]
    venue_description = venue_description_raw[venue_description_raw.find("<td>")+4:venue_description_raw.find("</td>")]

    name_raw = description[description.find("<th>NAME")+4:]
    name = name_raw[name_raw.find("<td>")+4:name_raw.find("</td>")]

    venue_dict[index]["address"] = address
    venue_dict[index]["postalCode"] = postal_code
    venue_dict[index]["description"] = venue_description
    venue_dict[index]["venueName"] = name

for index in corrupted_dict_index:
    venue_dict.pop(index)

url = "http://127.0.0.1:8080/api/venue/add"

for venue in venue_dict:
    response = requests.post(url, json=venue)
    print(response)


# insert government into user database
# INSERT INTO users(userid, username, firstname, lastname, email, password, birthday, phonenum, occupation,
# rganization, image) VALUES('277d24a0-6a05-41a1-aa4b-7cf749e8603d','government2020','government','2020',
# 'government2020@gov.sg','government2020',
#        '1965-08-09', 99999999,'government','government','assets/male-3.jpg');






