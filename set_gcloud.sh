#/bin/sh

# Set project, bucket and region

PROJECT='nyc-cabfare'    
BUCKET='nyc_cab' 
REGION='us-east1' 

## config cloud enviroment
gcloud config set project $PROJECT
gcloud config set compute/region $REGION