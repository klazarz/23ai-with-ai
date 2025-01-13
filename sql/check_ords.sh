#!/bin/bash

until nmap ords -PN -p 8181 | grep -q "open"; do
  echo "Waiting for ORDS to be ready..."
  sleep 5
done

echo "ORDS is ready. Starting the main service..."
exec /scripts/init.sh


