gcloud config set project miso-cloud-solutions-30102023

gcloud compute instances list

gcloud compute instances create virtual-machine-development-01 --zone=us-central1-a --machine-type=n1-standard-1 --image=projects/debian-cloud/global/images/debian-11-bullseye-v20230711

gcloud compute ssh --zone "us-central1-a" "virtual-machine-development-01" --project "miso-cloud-solutions-30102023"

gcloud compute instances stop virtual-machine-development-01

gcloud compute instances start virtual-machine-development-01 --zone=us-central1-a

gcloud compute instances delete virtual-machine-development-01 --zone=us-central1-a