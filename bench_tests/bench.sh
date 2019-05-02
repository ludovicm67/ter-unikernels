#!/bin/sh

clean_java() {
  rm -rf ./httpd_java/target
}

clean_all() {
  clean_java
  rm -f /tmp/results
}

display_section() {
  echo "\n\n\033[1m === $1 === \033[0m" >&2
}

wait_running() {
  unik ps 2> /dev/null | grep ServerImage | grep -q running
}

# $1: language
# $2: unikernel base
run_bench() {
  INITIAL_PATH=$(pwd)
  cd "./httpd_$1/"

  display_section "BUILD UNIKERNEL"

  BEGIN_TIME=$(date +%s%10N)

  if [ "$1" = "java" ]; then
    clean_java
    mvn package >&2
  fi

  unik build \
    --name ServerImage \
    --path ./ \
    --base "$2" \
    --language "$1" \
    --provider virtualbox \
    --force >&2

  IS_ERROR=$?

  END_TIME=$(date +%s%10N)
  BUILD_TIME=$(echo "($END_TIME - $BEGIN_TIME) / 10000000000" | bc -l | sed 's/0*$//')

  if [ $IS_ERROR -eq 0 ]; then
    display_section "RUN UNIKERNEL"

    BEGIN_TIME=$(date +%s%10N)

    unik run \
      --instanceName ServerInstance \
      --imageName ServerImage >&2

    IS_ERROR=$?

    END_TIME=$(date +%s%10N)
    RUN_TIME=$(echo "($END_TIME - $BEGIN_TIME) / 10000000000" | bc -l | sed 's/0*$//')
  fi

  cd "$INITIAL_PATH"

  if [ $IS_ERROR -ne 0 ]; then
    echo "ERROR!" 1>&2
    exit 1
  fi

  BEGIN_TIME=$(date +%s%10N)

  wait_running
  while [ $? -ne 0 ]; do
    echo -n "." >&2
    wait_running
  done

  END_TIME=$(date +%s%10N)
  LAUNCH_TIME=$(echo "($END_TIME - $BEGIN_TIME) / 10000000000" | bc -l | sed 's/0*$//')

  BEGIN_TIME=$(date +%s%10N)

  UNI_IP=$(unik ps 2> /dev/null | grep ServerImage | awk '{print $7}')
  while [ "$UNI_IP" = "running" ] || [ "$UNI_IP" = "ServerImage" ]; do
    echo -n "." >&2
    UNI_IP=$(unik ps 2> /dev/null | grep ServerImage | awk '{print $7}')
  done

  END_TIME=$(date +%s%10N)
  IP_TIME=$(echo "($END_TIME - $BEGIN_TIME) / 10000000000" | bc -l | sed 's/0*$//')

  echo "\n\n> Sever running on: http://$UNI_IP:1234" >&2

  eval $(
    {
      echo "time"
      for i in {1..100}; do
        curl -s -w "%{time_total}\n" -o /dev/null "http://$UNI_IP:1234"
      done
    } | sed 's/,/./' \
      | mlr --ofs space --itsv stats1 -a mean,min,max,median -f time
  )

  display_section "BENCHMARK RESULTS FOR: server in $1 on a $2 base"
  echo -n "language=$1"
  echo -n ",base=$2"
  echo -n ",build_time=${BUILD_TIME}"
  echo -n ",run_time=${RUN_TIME}"
  echo -n ",launch_time=${LAUNCH_TIME}"
  echo -n ",ip_time=${IP_TIME}"
  echo -n ",server_mean=${time_mean}"
  echo -n ",server_min=${time_min}"
  echo -n ",server_max=${time_max}"
  echo ",server_median=${time_median}"
}

clean_all

run_bench "java" "osv" | tee -a /tmp/results | mlr --oxtab cat
#run_bench "java" "rump" | tee -a /tmp/results | mlr --oxtab cat
run_bench "go" "rump" | tee -a /tmp/results | mlr --oxtab cat

display_section "ALL BENCHMARK RESULTS"
mlr --opprint cat /tmp/results

exit 0
