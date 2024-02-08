#!/bin/bash

# POSTGRES_DB=$(cat /conf/secrets/postgres_db)
# POSTGRES_DB_FILE="$POSTGRES_DB_FILE"
# POSTGRES_DB=$(cat "$POSTGRES_DB_FILE")



# Function to check if PostgreSQL is ready
is_postgres_ready() {
  pg_isready -h postgres -U user -d $POSTGRES_DB -q
}

# Wait for PostgreSQL to be ready
until is_postgres_ready; do
  echo "PostgreSQL is not ready yet. Waiting..."
  sleep 5
done

echo "PostgreSQL is ready now."

# Run ogr2ogr command
ogr2ogr -f "PostgreSQL" PG:"dbname=mydb user=user password=passwd host=postgres" -nlt PROMOTE_TO_MULTI -lco GEOMETRY_NAME=wkb_geometry data/shp_sc/shp_sc.shp

if [ $? -eq 0 ]; then
  echo "ogr2ogr added data/shp_sc/shp_sc.shp into PostgreSQL successfully"
else
  echo "ogr2ogr command failed with exit code $?"
fi
