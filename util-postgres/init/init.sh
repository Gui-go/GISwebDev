#!/bin/bash

sleep 10

echo "8888888888888888888888888888888888888888888888888888888888888888888888"

ls -a

# ogr2ogr -f "PostgreSQL" PG:"dbname=mydb user=user password=passwd host=postgres"  -nlt PROMOTE_TO_MULTI -lco GEOMETRY_NAME=wkb_geometry data/shp_sc/shp_sc.shp
ogr2ogr -f "PostgreSQL" PG:"dbname=mydb user=user password=passwd host=20.224.150.252 port=5432" -nlt PROMOTE_TO_MULTI -lco GEOMETRY_NAME=wkb_geometry -nln target_table_name data/shp_sc/shp_sc.shp

echo "8888888888888888888888888888888888888888888888888888888888888888888888"


