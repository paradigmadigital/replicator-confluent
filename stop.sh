#/bin/bash

stopEnvironment(){
 
  printf "\nRemoving environment...\n"	
  docker-compose stop
  docker-compose rm -f
  docker rmi -f datagen-europe
  docker rmi -f $(docker images --filter "dangling=true" -q --no-trunc)

}

stopEnvironment
