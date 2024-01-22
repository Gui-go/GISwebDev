import geopandas as gpd

# Replace 'your_shapefile.shp' with the actual path to your shapefile
shapefile_path = '/home/guigo/Documents/projects_dir/03-GISwebDev/GISwebDev/util-postgres/data/shp_zone/shp_BRuf_2022/BR_UF_2022.shp'

# Read the shapefile
gdf = gpd.read_file(shapefile_path)

# Display the original GeoDataFrame
print("Original GeoDataFrame:")
print(gdf)

# Filter features based on an attribute (replace 'attribute_name' and 'desired_value' accordingly)
attribute_name = 'NM_UF'
desired_value = 'Santa Catarina'
filtered_gdf = gdf[gdf[attribute_name] == desired_value]

# Display the filtered GeoDataFrame
print(f"\nFiltered GeoDataFrame where {attribute_name} equals {desired_value}:")
print(filtered_gdf)

filtered_shapefile_path = 'shpSC/filtered_shapefile.shp'

# Save the filtered data to a new shapefile
filtered_gdf.to_file(filtered_shapefile_path)
