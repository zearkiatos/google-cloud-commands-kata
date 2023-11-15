# code in python

### The library is:

```sh
$ pip install --upgrade google-cloud-pubsub
```


### You can check the next repository

```sh
$ git clone https://github.com/googleapis/python-pubsub.git
```

### The project has the next scripts

```sh
# This is to create the topic
python publisher.py $GOOGLE_CLOUD_PROJECT create MyTopic

# This is to get the list of topics 
python publisher.py $GOOGLE_CLOUD_PROJECT list

# This is for create the topic subscriber
python subscriber.py $GOOGLE_CLOUD_PROJECT create MyTopic MySub

# This to get a message
python subscriber.py $GOOGLE_CLOUD_PROJECT receive MySub

``````








