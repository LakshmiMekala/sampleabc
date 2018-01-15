#!/bin/bash

function get_test_cases {
    local my_list=( testcase1 )
    echo "${my_list[@]}"
}
function testcase1 {

./mqtt-gateway &
pId=$!
echo $PWD
mosquitto_sub -t "abc123" &
#value="$(mosquitto_sub -t "put")"
pId1=$!
#echo "$pId"
sleep 1

mosquitto_pub -m "{\"id\":1,\"name\":\"SPARROW\",\"photoUrls\":[],\"tags\":[]}" -t "put" &
pId2=$!
#echo "$pId"
sleep 5

echo $value

mosquitto_pub -m "{\"pathParams\":{\"petId\":\"1\"},\"replyTo\":\"abc123\"}" -t "get" &
pId3=$!
#echo "$pId"
sleep 5

var="$(mosquitto_sub -t "abc123")"

Kill -9 $pId
Kill -9 $pId1
Kill -9 $pId2
if [ "$var" == "{"id":1,"name":"SPARROW","photoUrls":[],"tags":[]}" ] 
        then 
            echo "PASS"
            
        else
            echo "FAIL"
            
    fi
}