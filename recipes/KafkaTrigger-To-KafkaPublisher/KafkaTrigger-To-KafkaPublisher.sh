function get_test_cases {
    local my_list=( testcase1 )
    echo "${my_list[@]}"
}
function testcase1 {

    pushd $GOPATH/kafka
    
    bin/zookeeper-server-start.sh config/zookeeper.properties &
    pId=$!
    #echo "$pId"
    sleep 40

    bin/kafka-server-start.sh config/server.properties &
    pId1=$!
    #echo "$pId"
    sleep 40

    bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic publishpet &
    pId2=$!
    sleep 30

    popd
    ./kafkatrigger-to-kafkapublisher &
    pId4=$!
    sleep 30

	echo "here1"
    
    cd $GOPATH/kafka
    current_time=$(date "+%Y.%m.%d-%H.%M.%S")
    #echo check now
    echo "{\"country\":\"USA\",\"Current Time\" :\"$current_time\"}" | bin/kafka-console-producer.sh --broker-list localhost:9092 --topic publishpet
    #bin/kafka-console-producer.sh --broker-list localhost:9092 --topic syslog   --property "parse.key=true"  --property "key.separator=:"  key1:USA &
    pId3=$!

    sleep 30
    
    var="$(bin/kafka-console-consumer.sh --topic subscribepet --bootstrap-server localhost:9092 --timeout-ms 9000 --consumer.config $GOPATH/kafka/config/consumer.properties)"
    
	echo "here2"
	
    #pId5=$!
    #sleep 10
    #echo VAR=$var
    #sleep 10
    echo "$var"
    kill -SIGINT $pId1
    kill -SIGINT $pId
    #kill -SIGINT $pId5
    kill -SIGINT $pId3
    kill -SIGINT $pId4
    sleep 20
    #echo "{\"country\":\"USA\",\"Current Time\" :\"$current_time\"}"

    if [ "$var" == "{\"country\":\"USA\",\"Current Time\" :\"$current_time\"}" ] 
        then 
            echo "PASS"
            
        else
            echo "FAIL"
            
    fi
}