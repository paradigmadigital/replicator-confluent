#/bin/bash

stopEnvironment(){
 
  printf "\nRemoving environment...\n"	
  cd infra/
  docker-compose stop
  docker-compose rm -f
  docker rmi -f datagen-europe
  docker rmi -f $(docker images --filter "dangling=true" -q --no-trunc)
  cd ../

  printf "\nDone!\n"

}

stopEnvironment
