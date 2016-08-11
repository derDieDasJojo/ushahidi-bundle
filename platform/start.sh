#!/bin/bash
set -o pipefail

# function: wait for service. waits for TCP service 
# param 1: Host
# param 2: Port
waitFor(){
  WAIT_HOST=$1
  WAIT_PORT=$2
  echo "waiting for $WAIT_HOST:$WAIT_PORT to come up .. "
  while ! echo exit | /bin/nc -zv $WAIT_HOST $WAIT_PORT; do sleep 5; done
  echo "Service $WAIT_HOST:$WAIT_PORT reached !"
}

#wait for mysql to be ready
waitFor mariadb 3306

#do migration if necessary
./bin/update --production

#start apache
/usr/local/bin/apache2-foreground
