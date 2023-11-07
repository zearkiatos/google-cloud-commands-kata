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