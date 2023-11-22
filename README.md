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