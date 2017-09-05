# Example 

## Overview
This is pretty much just a example of the most simple way to run NGINX in a container. This container simply returns a 200 and the value of the environment variable SERVER_NAME. This container is used for testing, acts as our app laying in the docker compose files.

## Usage 

### Building
```bash 
docker build -t nginx_example .
```

### Running
```bash
docker run -d -e SERVER_NAME=something nginx_example
```


