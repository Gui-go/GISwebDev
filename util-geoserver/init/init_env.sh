#!/bin/bash

ws_name="ws1"
ds_name="ds1"
layer_name="layer1"
# br_uf_2022
auth="admin:geoserver"

apk --no-cache add curl

# GeoServer REST API endpoints
base_url="http://geoserver:8080/geoserver/rest"
workspace_url="$base_url/workspaces"
datastore_url="$base_url/workspaces/$ws_name/datastores"
featuretype_url="$base_url/workspaces/$ws_name/datastores/$ds_name/featuretypes"

# Create a new workspace
curl -v -u $auth -X POST -H "Content-type: text/xml" -d "<workspace><name>$ws_name</name></workspace>" $workspace_url

# Create a PostGIS data store
curl -v -u $auth -X POST -H "Content-type: text/xml" -d \
"<dataStore>
    <name>$ds_name</name>
    <connectionParameters>
        <host>postgres</host>
        <port>5432</port>
        <database>mydb</database>
        <user>user</user>
        <passwd>passwd</passwd>
        <dbtype>postgis</dbtype>
    </connectionParameters>
</dataStore>" $datastore_url

# Create a new layer
curl -v -u $auth -X POST -H "Content-type: text/xml" -d \
"<featureType>
    <name>$layer_name</name>
    <nativeName>$layer_name</nativeName>
    <title>$layer_name</title>
    <srs>EPSG:4326</srs>
    <nativeBoundingBox>
        <minx>-180.0</minx>
        <maxx>180.0</maxx>
        <miny>-90.0</miny>
        <maxy>90.0</maxy>
    </nativeBoundingBox>
    <latLonBoundingBox>
        <minx>-180.0</minx>
        <maxx>180.0</maxx>
        <miny>-90.0</miny>
        <maxy>90.0</maxy>
    </latLonBoundingBox>
    <projectionPolicy>FORCE_DECLARED</projectionPolicy>
</featureType>" $featuretype_url

# Publish the layer
curl -v -u $auth -X POST -H "Content-type: text/xml" -d \
"<task><operation>generate</operation><data><layer>$featuretype_url</layer></data></task>" $featuretype_url


