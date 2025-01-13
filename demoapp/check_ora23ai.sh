#!/bin/bash

# Check if the `ora23ai` user can connect to the `sql` database
until echo "exit" | sqlplus ora23ai/ora23ai@23ai:1521/freepdb1; do
  echo "Waiting for SQL container to be ready..."
  sleep 30
done

echo "SQL container is ready. Starting Python application..."
exec python app.py  # Replace with the path to your Python app