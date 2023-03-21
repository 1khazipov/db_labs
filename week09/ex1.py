import geopy
import psycopg2
def update_address_table():
    geolocator = geopy.Nominatim(user_agent="my-application")
    connection = psycopg2.connect(database="dvdrental", user="postgres", password="12", host="127.0.0.1", port="5432")
    current = connection.cursor()
    current.execute("ALTER TABLE address ADD COLUMN latitude NUMERIC")
    current.execute("ALTER TABLE address ADD COLUMN longitude NUMERIC")
    current.execute("SELECT address_id, address, city_id FROM address WHERE address LIKE '%11%' AND city_id >= 400 AND city_id <= 600")
    lines = current.fetchall()
    for line in lines:
        loc = geolocator.geocode(line[1], timeout=10)
        if loc is not None:
            latit = loc.latitude
            longit = loc.longitude
        else:
            latit = 0
            longit = 0

        # Update the address table with the new latitude and longitude values
        current.execute("UPDATE address SET latitude = %s, longitude = %s WHERE address_id = %s", (latit, longit, line[0]))

    # Commit the changes and close the database connection
    connection.commit()
    current.close()
    connection.close()


update_address_table()
