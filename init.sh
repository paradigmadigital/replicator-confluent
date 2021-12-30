#/bin/bash

initEnvironment(){
 
  printf "\nBuilding producer application...\n"	
  docker images datagen-europe -q
  cd message-producer/
  rm -rf target/
  ./mvnw clean compile package
  docker build . -q -t datagen-europe
  cd ..

  printf "\nCreating clusters...\n"
  docker-compose stop
  docker-compose rm -f
  docker-compose up -d
  sleep 10

  printf "\nInstalling replicator connector libraries...\n"
  docker exec -it connect-north-america confluent-hub install confluentinc/kafka-connect-replicator:6.1.1 --no-prompt
  docker restart connect-north-america
  sleep 10

  printf "\nRegistering connector...\n"
  until $(curl --output /dev/null --silent -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @replicator.json); do
    printf '.'
    sleep 5
  done

}

initEnvironment
