#!/bin/bash

function get_test_cases {
    local my_list=( testcase1 )
    echo "${my_list[@]}"
}
function testcase1 {

    pushd $GOPATH/kafka
    
    bin/zookeeper-server-start.sh config/zookeeper.properties &
    pId=$!
    echo "zookeeper pid : [$pId]"
    sleep 10

    bin/kafka-server-start.sh config/server.properties &
    pId1=$!
    echo "kafka pid : [$pId1]"
    sleep 10

    bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic publishpet &
    pId2=$!
    echo "kafka create publishpet : [$pId2]"
    sleep 10

    popd

    ./kafkatrigger-to-kafkapublisher &
    pId4=$!
    echo "kafka gateway pid : [$pId4]"
    sleep 20

    cd $GOPATH/kafka
    current_time=$(date "+%Y.%m.%d-%H.%M.%S")
    echo "{\"country\":\"USA\",\"Current Time\" :\"$current_time\"}" | bin/kafka-console-producer.sh --broker-list localhost:9092 --topic publishpet &  pId3=$!
    
    echo "kafka pid3 : [$pId3]"

    sleep 2
    
    kafkaMessage="$(bin/kafka-console-consumer.sh --topic subscribepet --bootstrap-server localhost:9092 --timeout-ms 10000 --consumer.config $GOPATH/kafka/config/consumer.properties)"
    
	echo "kafka message value : [$kafkaMessage]"
	
 
    kill -SIGINT $pId1
    sleep 5
    kill -SIGINT $pId
    sleep 5
    kill -SIGINT $pId3
    sleep 5
    kill -SIGINT $pId4
    sleep 5

    echo "received message : [$kafkaMessage]" 
    echo "{\"country\":\"USA\",\"Current Time\" :\"$current_time\"}"

    if [ "$kafkaMessage" == "{\"country\":\"USA\",\"Current Time\" :\"$current_time\"}" ] 
        then 
            echo "PASS"   
        else
            echo "FAIL"
    fi
}
