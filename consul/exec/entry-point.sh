#!/bin/bash
set -eo pipefail
#shopt -s nullglob
#python3 run_app.py
attempt_counter=0
max_attempts=15
CONSULADDR=consul:8500
export CONSUL_HTTP_ADDR=$CONSULADDR
until $(curl --output /dev/null --silent --head --fail http://consul:8500); do
    if [ ${attempt_counter} -eq ${max_attempts} ];then
      echo "Max attempts reached"
      exit 1
    fi

    printf '.'
    attempt_counter=$(($attempt_counter+1))
    sleep 5
done
echo "----------------"
sleep 10
echo ADDING NEW KEY/VALUE IN CONSUL REMOTE
cd /usrt/bin/
./consul kv put "application/BOOKS/NAME" "The Raven of god"
echo  "----------------"
cd /usr/src/app/
./envconsul -kill-signal=SIGHUP -upcase -sanitize -prefix application -consul $CONSULADDR -log-level debug "$@"