# 23ai Demo Env - with Ollama and ONNX support



podman run --rm --name ords -v ./ords_secrets/:/opt/oracle/variables -v ./ords_config/:/etc/ords/config/ -p 8181:8181 container-registry.oracle.com/database/ords-developer:latest 