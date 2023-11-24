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

gcloud config set compute/region us-central1

export REGION=us-central1

export ZONE=us-central1-c

gcloud compute instances create gcelab2 --machine-type e2-medium --zone=$ZONE

gcloud compute instances create --help

gcloud compute ssh gcelab2 --zone=$ZONE

gcloud compute instances get-serial-port-output instance-1

gcloud compute reset-windows-password  instance-1 --zone us-east1-d --user admin


gcloud config set compute/region us-central1


gcloud config set compute/zone us-central1-c

  gcloud compute instances create www1 \
    --zone=us-central1-c \
    --tags=network-lb-tag \
    --machine-type=e2-small \
    --image-family=debian-11 \
    --image-project=debian-cloud \
    --metadata=startup-script='#!/bin/bash
      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "
<h3>Web Server: www1</h3>" | tee /var/www/html/index.html'

gcloud compute firewall-rules create www-firewall-network-lb \
    --target-tags network-lb-tag --allow tcp:80

gcloud compute addresses create network-lb-ip-1 \
  --region us-central1

gcloud compute http-health-checks create basic-check

gcloud compute target-pools create www-pool \
  --region us-central1 --http-health-check basic-check

gcloud compute target-pools add-instances www-pool \
    --instances www1,www2,www3

gcloud compute forwarding-rules create www-rule \
    --region  us-central1 \
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool



gcloud compute forwarding-rules describe www-rule --region us-central1

# Access to the external ip address
IPADDRESS=$(gcloud compute forwarding-rules describe www-rule --region us-central1 --format="json" | jq -r .IPAddress)

# Create the loadbalance address
gcloud compute instance-templates create lb-backend-template \
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

gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2 --zone=us-central1-c

gcloud compute firewall-rules create fw-allow-health-check \
  --network=default \
  --action=allow \
  --direction=ingress \
  --source-ranges=130.211.0.0/22,35.191.0.0/16 \
  --target-tags=allow-health-check \
  --rules=tcp:80

  gcloud compute addresses create lb-ipv4-1 \
  --ip-version=IPV4 \
  --global


gcloud compute addresses describe lb-ipv4-1 \
  --format="get(address)" \
  --global

gcloud compute health-checks create http http-basic-check \
  --port 80

gcloud compute backend-services create web-backend-service \
  --protocol=HTTP \
  --port-name=http \
  --health-checks=http-basic-check \
  --global

gcloud compute backend-services add-backend web-backend-service \
  --instance-group=lb-backend-group \
  --instance-group-zone=us-central1-c \
  --global


gcloud compute url-maps create web-map-http \
    --default-service web-backend-service

gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map-http

gcloud compute forwarding-rules create http-content-rule \
   --address=lb-ipv4-1\
   --global \
   --target-http-proxy=http-lb-proxy \
   --ports=80