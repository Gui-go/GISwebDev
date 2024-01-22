




# sudo snap install google-cloud-cli --classic
gcloud auth login
gcloud config set project pointfln

docker build -t gcr.io/pointfln/pointfln_img:latest .

docker build -t gcr.io/pointfln/pointfln_img:latest -f Dockerfile.cloudrun .
docker push gcr.io/YOUR_PROJECT_ID/YOUR_IMAGE_NAME:latest


docker-compose push

















