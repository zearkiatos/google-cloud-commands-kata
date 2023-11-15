gcloud config set project miso-cloud-solutions-30102023

gcloud compute instances list

gcloud compute instances create virtual-machine-development-01 --zone=us-central1-a --machine-type=n1-standard-1 --image=projects/debian-cloud/global/images/debian-11-bullseye-v20230711

gcloud compute ssh --zone "us-central1-a" "virtual-machine-development-01" --project "miso-cloud-solutions-30102023"

gcloud compute instances stop virtual-machine-development-01

gcloud compute instances start virtual-machine-development-01 --zone=us-central1-a

gcloud compute instances delete virtual-machine-development-01 --zone=us-central1-a

gcloud config list

gsutil ls gs://cloud-development-storage

gsutil cp example-file.txt gs://cloud-development-storage/docs

gcloud pubsub topics create myTopic

gcloud pubsub topics list

gcloud pubsub topics delete Test1

gcloud pubsub topics delete Test2

gcloud pubsub topics list

gcloud  pubsub subscriptions create --topic myTopic mySubscription

gcloud pubsub topics list-subscriptions myTopic

gcloud pubsub subscriptions delete Test1

gcloud pubsub topics publish myTopic --message "Hello"

gcloud pubsub subscriptions pull mySubscription --auto-ack

gcloud pubsub subscriptions pull mySubscription --auto-ack --limit=3