#!/bin/bash

function get_test_cases {
    local my_list=( testcase1 )
    echo "${my_list[@]}"
}
function testcase1 {

./mqtt-gateway &
pId=$!
echo "$pId"
#starting mosquitto_sub in background and copying logs into temp file
mosquitto_sub -t "abc123" > /tmp/test.log & pId1=$!
mosquitto_pub -m "{\"id\":1,\"name\":\"SPARROW\",\"photoUrls\":[],\"tags\":[]}" -t "put"
sleep 5
mosquitto_pub -m "{\"pathParams\":{\"petId\":\"1\"},\"replyTo\":\"abc123\"}" -t "get"
sleep 5
var=$(cat /tmp/test.log)
echo $var

#killing process
kill -9 $pId
kill -9 $pId1
actualValue="{\"category\":{\"id\":1,\"name\":\"string\"},\"id\":1,\"name\":\"doggie2\",\"photoUrls\":[\"string\"],\"status\":\"available\",\"tags\":[{\"id\":0,\"name\":\"string\"}]}"
echo $actualValue
if [ "$var" == "$actualValue" ] 
        then 
            echo "PASS"
            
        else
            echo "FAIL"
            
    fi
	rm -f /tmp/test1.log	
}