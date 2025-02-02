# 23ai Demo Env - with Ollama and ONNX support


# Step-by-step


1. podman compose up (I failed 2 times on me with different weird errors-the third time I started it, it succeeded)
2. Once everything is ready you should be able to access the following URLs:
   1. localhost:8182 (the webapp)
   2. localhost:8181 (ORDS landing page)
3. We now need to manually load data.
   1. if you are on a Mac or PC with Intel chip you can also import the All-MiniLM.ONNX model. 23ai free ARM does not support ONNX models!
   2. to load the model, change to mode/ and run the script: ./load_model_2_db.sh
4. Load data and enable all users
   1. connect to SQLcl container: podman exec -it sql /bin/bash and run ./init.sh
      - This will install Oracle Sample data 
      - It will also ORDS-enable all users
   2. Load the sql/country.json - easiest is to use Mongo Compass
      - Connect string: mongodb://ora23ai:ora23ai@localhost:27017/ora23ai?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true&tlsAllowInvalidCertificates=true
      - Import the JSON into the COUNTRIES collection table
   3. Connect to SQLDev web (or use SQL Developer local or the SQL Dev extension in VSCode)
      - Connect as ora23ai/ora23ai and run the manual.sql in /sql

That's it. The webapp should work now (on Macs with M chip you cannot use Vectorize and Similarity Search)
Final bit: REST-Enable the JSON Duality View CUSTOMER_DV (I usually do this as part of the demo flow)


## Things to fix
- Steps 3 & 4 need to be automated
- Use an environment variable in the dockerfiledemo to set the DB password



# Cheat sheet (docker commands - podman should work the same, may have to skip sudo)

sudo docker exec -it ollama /bin/bash

## quick and dirty app rebuild (mac)
sudo docker-compose stop demo && sudo docker rm demo && sudo docker image rm 23ai-with-ai-demo && sudo docker-compose up -d 

## quick and dirty app rebuild (linux)
sudo docker compose stop demo && sudo docker rm demo && sudo docker image rm 23ai-with-ai-demo && sudo docker compose up -d 