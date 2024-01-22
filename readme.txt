


git config --global user.name "guigo"
git config --global user.email "guilhermeviegas1993@gmail.com"









# GIS web development


# Allow Docker not to use sudo:
sudo usermod -aG docker $USER
docker run hello-world
sudo systemctl start docker
restart docker


# Instal Node Package Manager - NPM:
sudo apt install npm
npx create-react-app react-app


docker exec -it giswebdev_postgres_1 /bin/bash
docker exec -it giswebdev_postgres_1 psql -U user -d mydb -h localhost -p 5432
CREATE EXTENSION postgis;
SELECT PostGIS_version();

\l -- List all databases
\c your_database_name -- Connect to a specific database
\dn -- List all schemas in the current database
\dt -- List all tables in the current schema
\d your_table_name -- Show details of a specific table
\du -- List all users
\du your_username -- Show details of a specific user
\q

CREATE DATABASE db1


CREATE TABLE your_line_table (
  id serial PRIMARY KEY,
  name varchar(255),
  geom geometry(LineString, 4326)
);

INSERT INTO your_line_table (name, geom)
VALUES (
  'Sample Line',
  ST_GeomFromText('LINESTRING(0 0, 10 10, 20 0)', 4326)
);



sudo docker-compose ps
docker inspect giswebdev_postgres_1
docker inspect giswebdev_geoserver_1

docker-compose logs geoserver
docker-compose logs geoserver postgres


docker exec -it giswebdev_geoserver_1 /bin/bash
curl -v -u admin:geoserver -XPOST -H "Content-type: text/xml" -d "<workspace><name>acme</name></workspace>" http://localhost:8080/geoserver/rest/workspaces
curl -u admin:passwd -XGET http://localhost:8080/geoserver/rest/workspaces.json







response = requests.post(f'http://admin:geoserver@geoserver:8080/geoserver/rest/workspaces', data=f'<workspace><name>ws1</name></workspace>', headers={'Content-type': 'text/xml'}).raise_for_status()
