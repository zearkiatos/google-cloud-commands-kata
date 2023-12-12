# Description
This is a project to practice how to use gcloud cli ☁️

# Made with
[![GCP](https://img.shields.io/badge/GCP-489f50?style=for-the-badge&logo=googlecloud&logoColor=white&labelColor=000000)]()

# Gcloud commands

```sh
    # List your projects
    $ gcloud projects list

    # Set your project
    $ gcloud config set project [TYPE YOUR PROJECT NAME]

    # List your computers engines instances
    $ gcloud compute instances list

    # Create a new instance
    $ gcloud compute instances create [INSTANCE NAME] --zone=[ZONE] --machine-type=[MACHINE TYPE] --image=[VIRTUAL MACHINE TYPE]

    # Connect to the virtual machine
    $ gcloud compute ssh --zone [ZONE] "[INSTANCE NAME]" --project "[PROJECT NAME]"

    # Check the network data
    $ ip a

    # Stop the instance
    $ gcloud compute instances stop [INSTANCE NAME]

    # Start the instance with a specific zone
    $ gcloud compute instances start [INSTANCE NAME] --zone=[ZONE]

    # Delete the instance
     $ gcloud compute instances delete [INSTANCE NAME] --zone=[ZONE]
```

## Connect to a CloudSQL ☁️ Instance in postgres 🐘

```sh
# Set as super admin
$ sudo su

# Update the repositories
$ apt-get update

# Install postgres 🐘 client
$ apt-get install postgresql-client

# Connect to the postgresql 🐘 database
$ psql --host=[THE DATABASE INSTANCE] --port=5432 --username=[YOUR USERNAME] --password --dbname=[YOUR DATABASE NAME]
```

## Working with Google storage and buckets 🗑️

```sh
# Command to check where you are account, and project
$ gcloud config list

# How to management the storage

#List your root bucket content or inside a folder
$ gsutil ls gs://[YOUR BUCKET NAME]

# Copy a file inside the bucket
$ gsutil cp [YOUR FILE NAME 📝] gs://[YOUR BUCKET NAME]/[AN SPECIFIC FOLDER 📁]
```

## Google cloud ☁️ pub/sub
 ```sh
 # This command is for create a topic
 $ gcloud pubsub topics create [TOPIC NAME]

 # This command is for list the topics
 $ gcloud pubsub topics list

  # This command is for delete the topic
 $ gcloud pubsub topics delete [TOPIC NAME]

 # This command is for create a subscription for an specific topic
 $ gcloud  pubsub subscriptions create --topic [TOPIC NAME] [SUBSCRIPTION NAME]

  # This command is for list the subscription of an specific topic
 $ gcloud pubsub topics list-subscriptions [TOPIC NAME]

  # This command is for delete a subscription
 $ gcloud pubsub subscriptions delete [SUBSCRIPTION NAME]
 # This command is for send a message to the topic
 $ gcloud pubsub topics publish [TOPIC NAME] --message [YOUR MESSAGE]

 # This command is for get the message from the subscription
 $ gcloud pubsub subscriptions pull [SUBSCRIPTION] --auto-ack

  # Thiscommand is for download the messages until the limit
 $ gcloud pubsub subscriptions pull [SUBSCRIPTION] --auto-ack --limit=[THE QUANTITY OF MESSAGE TO GET]

 ```

 ## Cloud engine for Linux 🐧

 ```sh

#set region zone

gcloud config set compute/region [YOUR REGION NAME]

# variable for region

export REGION=[YOUR REGION NAME]

# variable for zone
export ZONE=[YOUR ZONE NAME]

# create a new instance

gcloud compute instances create [YOUR VIRTUAL MACHINE INSTANCE NAME] --machine-type e2-medium --zone=$ZONE

# to see default run
gcloud compute instances create --help

# To connect to the VMs

gcloud compute ssh [YOUR VIRTUAL MACHINE INSTANCE NAME] --zone=$ZONE

 ```

 ## Compute engine with windows 🪟 virtual machine

```sh
# Check if the RDP is allow
gcloud compute instances get-serial-port-output [INSTANCE NAME]

gcloud compute reset-windows-password  [INSTANCE NAME] --zone [ZONE] --user [USERNAME]
```

# Data base connection

gcloud sql connect myinstance --user=postgres

# Cloud loadbalance
```sh
# Set default region
$ gcloud config set compute/region [THE REGION]

# In Cloud Shell, set the default zone:

$ gcloud config set compute/zone [ZONE]

# Create virtual machine

$ gcloud compute instances create [INSTANCE NAME] \
    --zone=[ZONE] \
    --tags=[TAG NAME] \
    --machine-type=[MACHINE TYPE] \
    --image-family=debian-11 \
    --image-project=[PROJECT IMAGE] \
    --metadata=startup-script=[STARTUP SCRIPT]

# Config firewall
$ gcloud compute firewall-rules create [LOADBALANCE NAME] \
    --target-tags [TAG] --allow tcp:80

# Create a healthcheck

$ gcloud compute http-health-checks create [HEALTHCHECK NAME]
 
# Add target to the pool
$ gcloud compute target-pools create www-pool \
  --region [REGION] --http-health-check [HEALTH CHECK NAME]

# Add the instances

$ gcloud compute target-pools add-instances www-pool \
    --instances [INSTANCES SEPARATE WITH COLON]

# Add forwarding tools
$ gcloud compute forwarding-rules create [RULE NAME] \
    --region [REGION] \
    --ports [PORT] \
    --address [LOADBALANCE] \
    --target-pool www-pool

# Forwarding

$ gcloud compute forwarding-rules describe www-rule --region [REGION]

# Access to   the external IP
$ IPADDRESS=$(gcloud compute forwarding-rules describe www-rule --region [REGION] --format="json" | jq -r .IPAddress)

# Load balance address
$ gcloud compute instance-templates create lb-backend-template \
   --region=us-central1 \
   --network=default \
   --subnet=default \
   --tags=allow-health-check \
   --machine-type=e2-medium \
   --image-family=debian-11 \
   --image-project=debian-cloud \
   --metadata=startup-script='#!/bin/bash
     apt-get update
     apt-get install apache2 -y
     a2ensite default-ssl
     a2enmod ssl
     vm_hostname="$(curl -H "Metadata-Flavor:Google" \
     http://169.254.169.254/computeMetadata/v1/instance/name)"
     echo "Page served from: $vm_hostname" | \
     tee /var/www/html/index.html
     systemctl restart apache2'

# Managed instance group

gcloud compute instance-groups managed create lb-backend-group \
   --template=[TEMPLATE] --size=2 --zone=[ZONE]

# Allow healthcheck in the firewall

$ gcloud compute firewall-rules create fw-allow-health-check \
  --network=default \
  --action=allow \
  --direction=ingress \
  --source-ranges=130.211.0.0/22,35.191.0.0/16 \
  --target-tags=allow-health-check \
  --rules=tcp:80

  # Set global static external ip for loadbalance
  gcloud compute addresses create lb-ipv4-1 \
  --ip-version=IPV4 \
  --global

# Get the reserved IP

gcloud compute addresses describe lb-ipv4-1 \
  --format="get(address)" \
  --global

# Create a healthcheck load balance
gcloud compute health-checks create http http-basic-check \
  --port 80

# Create a backend service
gcloud compute backend-services create web-backend-service \
  --protocol=HTTP \
  --port-name=http \
  --health-checks=http-basic-check \
  --global

# add the backend to the instance group
gcloud compute backend-services add-backend web-backend-service \
  --instance-group=lb-backend-group \
  --instance-group-zone=us-central1-c \
  --global

# URL Map

gcloud compute url-maps create web-map-http \
    --default-service web-backend-service

# Create a http proxu
gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map-http

# Create a global firewall
gcloud compute forwarding-rules create http-content-rule \
   --address=lb-ipv4-1\
   --global \
   --target-http-proxy=http-lb-proxy \
   --ports=80
```

# Internal loadbalance

```sh

```

# Deploy an application on Cloud run


```sh
# Auth to google docker configuration
$  gcloud auth configure-docker

# Create a docker tag in the google cloud artifact
$   gcloud builds submit --tag [TAG THE DOCKER IMAGE WITH THE REGISTRY]

# Deploy the imaage
$ gcloud run deploy monolith --image [TAG THE DOCKER IMAGE WITH THE REGISTRY] --region [ADD THE REGION]

# List the images
$ gcloud run services list

# Deploy the services
$ gcloud run services describe monolith --platform managed --region [ADD THE REGION]
```

# Cloud storage

```sh
 # Download a image into a bucket
  $ curl https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg --output ada.jpg

 $ gsutil cp ada.jpg gs://[YOUR BUCKET NAME]

 # Download from bucket 
 $ gsutil cp -r gs://[YOUR BUCKET NAME]/ada.jpg .
    
  # Copy a image in the same bucket
    
  $ gsutil cp gs://[YOUR BUCKET NAME]/ada.jpg gs://[YOUR BUCKET NAME]/image-folder/
    
  # List content bucket
    
  $ gsutil ls gs://[YOUR BUCKET NAME]
    
  # List content bucket with details
    
  $ gsutil ls -l gs://[YOUR BUCKET NAME]/ada.jpg
    
  # manipulate access with public
    
  $ gsutil acl ch -u AllUsers:R gs://[YOUR BUCKET NAME]/ada.jpg
    
  # Remove publish access
    
  $ gsutil acl ch -d AllUsers gs://[YOUR BUCKET NAME]/ada.jpg
    
  # delete objects
    
  $ gsutil rm gs://[YOUR BUCKET NAME]/ada.jpg
```