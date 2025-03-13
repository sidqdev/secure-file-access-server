import uuid
import logging
import redis
from fastapi import FastAPI, Depends
from pydantic import BaseModel

import auth

app = FastAPI()
r = redis.Redis("redis")

class ProxyData(BaseModel):
    url: str
    ttl: str = None
    token: str = None


@app.post("/generate-proxy/")
async def generate_proxy(proxy_data: ProxyData, token: str = Depends(auth.get_token)):
    if proxy_data.token is None:
        proxy_data.token = uuid.uuid4().hex
    
    resp = r.set(
        proxy_data.token,
        proxy_data.url,
        ex=proxy_data.ttl,
    )
    logging.info(resp)

    return {"token": proxy_data.token}
