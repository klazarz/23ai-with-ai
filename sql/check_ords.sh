#!/bin/bash

until curl -s http://ords:8181 > /dev/null; do
  echo "Waiting for ORDS to be ready..."
  sleep 5
done

# echo "ORDS is ready. Starting the main service..."
exec /scripts/init.sh


