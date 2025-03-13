function mysplit(inputstr, sep)
    -- if sep is null, set it as space
    if sep == nil then
       sep = '%s'
    end
    -- define an array
    local t={}
    -- split string based on sep   
    for str in string.gmatch(inputstr, '([^'..sep..']+)') 
    do
       -- insert the substring in table
       table.insert(t, str)
    end
    -- return the array
    return t
end
 
local key = ngx.var.request_uri:gsub("/", "")


if not key then
    ngx.log(ngx.ERR, "no key requested")
    return ngx.exit(400)
end

local redis = require "resty.redis"
local red = redis:new()

red:set_timeout(1000) -- 1 second

local ok, err = red:connect("redis", 6379)
if not ok then
    ngx.log(ngx.ERR, "failed to connect to redis: ", err)
    return ngx.exit(500)
end

local value, err = red:get(key)

if not value then
    ngx.log(ngx.ERR, "failed to get redis key: ", err)
    ngx.status = 500
    ngx.say("Something not right")
    return ngx.exit(ngx.OK)
end

if value == ngx.null then
    ngx.log(ngx.ERR, "no host found for key ", key)
    ngx.status = 404
    ngx.say("Not found peric")
    return ngx.exit(ngx.OK)
end


if value then
    local parts = mysplit(value, "/")
    ngx.var.filename = parts[#parts]
    ngx.var.target = value
    return
end
