#!/bin/bash

if [ -f '/vault/secrets/secrets' ]; then
  source /vault/secrets/secrets
fi

uvicorn main:app --host 0.0.0.0 --port 1234
