local LambdaService = require "api-gateway.aws.lambda.LambdaService"
local cjson = require "cjson"

-- convert query request into event payload

local payload = {}
payload["httpMethod"] = ngx.req.get_method()
--payload["body"] = ngx.req.get_post_args()
payload["requestContext"] = {}
payload["requestContext"]["httpMethod"] = ngx.req.get_method()
payload["requestContext"]["requestId"] = ngx.var.request_id
payload["queryStringParameters"] = ngx.req.get_uri_args()
payload["headers"] = ngx.req.get_headers()
payload["path"] = ngx.var.uri


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

-- invoke the function
local functionName = ngx.var.aws_function
local invokeResult, code, headers, status, resp  = service:invoke(functionName, payload, context_json)

ngx.log(ngx.WARN,type(resp))
ngx.log(ngx.WARN,resp)

local resp_tab = cjson.decode(resp)
ngx.log(ngx.WARN,type(resp_tab))


ngx.log(ngx.WARN,type(status))
ngx.log(ngx.WARN,type(resp_tab["statusCode"]))
ngx.log(ngx.WARN,resp_tab["statusCode"])

ngx.status = status

-- parse the response like api gate way would
local body = resp_tab["body"]
ngx.log(ngx.WARN,type(body))

ngx.log(ngx.WARN,type(resp_tab["headers"]))
for header, value in pairs(resp_tab["headers"]) do 
    ngx.log(ngx.WARN,type(header))
    ngx.log(ngx.WARN,header)
    ngx.log(ngx.WARN,type(value))
    ngx.log(ngx.WARN,value)
     
    ngx.header[header] = value
end

ngx.say(body)
