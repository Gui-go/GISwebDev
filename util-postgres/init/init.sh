#!/bin/bash

sleep 10

ogr2ogr -f "PostgreSQL" PG:"dbname=mydb user=user password=passwd host=postgres"  -nlt PROMOTE_TO_MULTI -lco GEOMETRY_NAME=wkb_geometry data/shp_sc/shp_sc.shp



