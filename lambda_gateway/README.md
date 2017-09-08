# NGINX Lambda Gateway
This is a project that allows you to call a lambda function through an API. 

## Usage (for now)
```
docker build -t lambda_gateway .
docker run -e AWS_FUNCTION='arn:aws:lambda:us-east-1:<ACCOUNT_ID>:function:<FUNCTION NAME>' -e AWS_REGION=us-east-1 -e AWS_ACCESS_KEY_ID=<ACCESS_KEY> -e AWS_SECRET_ACCESS_KEY=<SECRET_KEY> -d lambda_gateway
```
