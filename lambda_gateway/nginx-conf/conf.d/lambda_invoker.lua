local LambdaService = require "api-gateway.aws.lambda.LambdaService"
local cjson = require "cjson"
local service = LambdaService:new({
    aws_region = ngx.var.aws_region,
    aws_credentials = {
        provider = "api-gateway.aws.AWSBasicCredentials",
        access_key = ngx.var.aws_access_key_id,
        secret_key = ngx.var.aws_secret_access_key
    },
    aws_debug = true,              -- print warn level messages on the nginx logs
    aws_conn_keepalive = 60000,    -- how long to keep the sockets used for AWS alive
    aws_conn_pool = 100            -- the connection pool size for sockets used to connect to AWS
})

-- convert query params into event payload
-- local payload = cjson.encode({ requestContext = { httpMethod = ngx.req.method } })
local payload = {}
payload["requestContext"] = {}
payload["requestContext"]["httpMethod"] = ngx.req.get_method()
payload["queryStringParameters"] = ngx.req.get_uri_args()
payload["headers"] = ngx.req.get_headers()


-- invoke the function
local functionName = ngx.var.aws_function
local invokeResult, code, headers, status, body  = service:invoke(functionName, payload, context_json)

ngx.say(tostring(body))
