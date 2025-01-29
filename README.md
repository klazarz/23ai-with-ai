# 23ai Demo Env - with Ollama and ONNX support


# Cheat sheet

sudo docker exec -it ollama /bin/bash


## quick and dirty app rebuild (mac)
sudo docker-compose stop demo && sudo docker rm demo && sudo docker image rm 23ai-with-ai-demo && sudo docker-compose up -d 

## quick and dirty app rebuild (linux)
sudo docker compose stop demo && sudo docker rm demo && sudo docker image rm 23ai-with-ai-demo && sudo docker compose up -d 