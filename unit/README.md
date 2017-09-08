# NGINX Unit Container
This is a NGINX Unit application server. 

## How to use:
### Build Container
```
docker build -t unit .
```

### Run container:
```
docker run -d unit
```
### Configure App:
```
curl -X PUT -d @python.json http://<container_ip>:8080/applications/hello
```
### Add a listener for the app
```
curl -X PUT -d '{ "*:8300": { "application": "hello" } }" http://<container_ip>:8080/listeners/
```
### Curl application:
```
curl <container_ip>:8300/
```
