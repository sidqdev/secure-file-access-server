
# Secure fast access server

Serve the files by generated token with ttl with maximum speed.

To run the project: 

```docker compose up --build -d```

Env:

```API_TOKEN=<token to pass in Authorization: Bearer to create file token>```

How to use:

```python
requests.post(
    url="http://0.0.0.0:8080/generate-proxy/", 
    json={
        "url": "file_url",
        "token": "c62fa8de7fe64b7dac3a90cdd84c9a65" # Optional, default = new uuid
        "ttl": 10, # In seconds, optional, default=None
    }, 
    headers={"Authorization": "Bearer test"}
).text
>>> '{"token":"c62fa8de7fe64b7dac3a90cdd84c9a65"}'

# To get ur file
requests.get("http://0.0.0.0:8080/c62fa8de7fe64b7dac3a90cdd84c9a65/")
```