#/bin/bash

BASEDIR=$(dirname "$0")

initEnvironment(){
  printf "\nRemoving environment...\n"	
  docker-compose stop
  docker-compose rm -f
  docker volume rm $(docker volume ls -q)
  printf "\nStarting environment...\n"
  docker-compose up -d
  sleep 10
  #docker exec -it connect confluent-hub install confluentinc/kafka-connect-jdbc:10.1.1
  #docker exec -it connect confluent-hub install mongodb/kafka-connect-mongodb:1.5.0
  docker exec -it connect confluent-hub install confluentinc/kafka-connect-replicator:6.1.1 --no-prompt
  #docker cp debezium-connectors/debezium-connector-db2/ connect:/usr/share/confluent-hub-components/
  ######docker cp debezium-connectors/debezium-connector-oracle/ connect:/usr/share/confluent-hub-components/
  #docker exec -it connect confluent-hub install debezium/debezium-connector-mongodb:1.5.0 --no-prompt
  #docker exec -it connect confluent-hub install debezium/debezium-connector-mysql:1.5.0 --no-prompt
  ######docker exec -it connect confluent-hub install debezium/debezium-connector-postgresql:1.7.0 --no-prompt


  docker stop connect
  docker start connect

  #sleep 60

  #curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @pgsql-connector-avro.json

  #sleep 10

  #curl -XPOST localhost:5601/api/kibana/dashboards/import -H 'kbn-xsrf:true' -H 'Content-type:application/json' -d @dashboard.json

}

initEnvironment
