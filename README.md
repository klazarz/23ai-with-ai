# 23ai Demo Env - with Ollama and ONNX support



podman run --rm --name ords -v ./ords_secrets/:/opt/oracle/variables -v ./ords_config/:/etc/ords/config/ -p 8181:8181 container-registry.oracle.com/database/ords-developer:latest 



Cheat sheet

sudo docker exec -it ollama /bin/bash



sudo docker-compose stop demo && sudo docker rm demo && sudo docker image rm 23ai-with-ai-demo && sudo docker-compose up -d 