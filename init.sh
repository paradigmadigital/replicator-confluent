#/bin/bash

initEnvironment(){
 
  printf "\nBuilding producer application...\n"	
  docker images datagen-europe -q
  cd message-producer/
  rm -rf target/
  ./mvnw clean compile package >> /dev/null
  docker build . -q -t datagen-europe
  cd ..

  printf "\nCreating clusters...\n"
  docker-compose stop
  docker-compose rm -f
  docker-compose up -d

  printf "\nInstalling Confluent Kafka Replicator connector libraries...\n"
  sleep 20
  docker exec -it connect-north-america confluent-hub install confluentinc/kafka-connect-replicator:6.1.1 --no-prompt >> /dev/null
  docker restart connect-north-america >> /dev/null
  

  printf "\nRegistering Confluent Kafka Replicator connector...\n"
  sleep 60
  curl --output /dev/null --silent -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @replicator.json >> /dev/null

}

initEnvironment
