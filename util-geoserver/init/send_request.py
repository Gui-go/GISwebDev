import requests
import time

ws_name = "ws1"
ds_name = "ds1"
layer_name = "layer1"
layer_name2 = "shp_sc"
auth = ('admin', 'geoserver')

# GeoServer REST API endpoints
base_url = 'http://geoserver:8080/geoserver/rest'
workspace_url = f'{base_url}/workspaces'
datastore_url = f'{base_url}/workspaces/{ws_name}/datastores'
featuretype_url = f'{base_url}/workspaces/{ws_name}/datastores/{ds_name}/featuretypes'

# Retry settings
max_retries = 10
retry_interval = 5

# Function to check if GeoServer is ready
def is_geoserver_ready():
    try:
        response = requests.get(base_url, auth=auth)
        return response.status_code == 200
    except requests.exceptions.RequestException:
        return False

# Wait for GeoServer to be ready
retry_count = 0
while not is_geoserver_ready() and retry_count < max_retries:
    print("Waiting for GeoServer to be ready...")
    time.sleep(retry_interval)
    retry_count += 1

if not is_geoserver_ready():
    print("Max retries exceeded. Unable to connect to GeoServer.")
else:
    workspace_data = f'<workspace><name>{ws_name}</name></workspace>'
    response_workspace = requests.post(workspace_url, data=workspace_data, headers={'Content-type': 'text/xml'}, auth=auth)
    print(f'Create Workspace Status Code: {response_workspace.status_code}')
    print(f'Create Workspace Response: {response_workspace.text}')

    # Create a PostGIS data store
    datastore_data = f'''
    <dataStore>
        <name>{ds_name}</name>
        <connectionParameters>
            <host>postgres</host>
            <port>5432</port>
            <database>mydb</database>
            <user>user</user>
            <passwd>passwd</passwd>
            <dbtype>postgis</dbtype>
        </connectionParameters>
    </dataStore>
    '''
    response_datastore = requests.post(datastore_url, data=datastore_data, headers={'Content-type': 'text/xml'}, auth=auth)
    print(f'Create Data Store Status Code: {response_datastore.status_code}')
    print(f'Create Data Store Response: {response_datastore.text}')

    # Create a new layer
    layer_data = f'''
    <featureType>
        <name>{layer_name}</name>
        <nativeName>{layer_name}</nativeName>
        <title>{layer_name}</title>
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
    </featureType>
    '''
    response_layer1 = requests.post(featuretype_url, data=layer_data, headers={'Content-type': 'text/xml'}, auth=auth)
    print(f'Create Layer Status Code: {response_layer1.status_code}')
    print(f'Create Layer Response: {response_layer1.text}')

    # Create a new layer
    layer_data2 = f'''
    <featureType>
        <name>{layer_name2}</name>
        <nativeName>{layer_name2}</nativeName>
        <title>{layer_name2}</title>
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
    </featureType>
    '''
    response_layer2 = requests.post(featuretype_url, data=layer_data2, headers={'Content-type': 'text/xml'}, auth=auth)
    print(f'Create Layer Status Code: {response_layer2.status_code}')
    print(f'Create Layer Response: {response_layer2.text}')


    # Publish the layer
    publish_data = f'<task><operation>generate</operation><data><layer>{featuretype_url}</layer></data></task>'
    response_publish = requests.post(featuretype_url, data=publish_data, headers={'Content-type': 'text/xml'}, auth=auth)
    print(f'Publish Layer Status Code: {response_publish.status_code}')
    print(f'Publish Layer Response: {response_publish.text}')


print("GeoServer is ready. Proceeding with REST API requests.")