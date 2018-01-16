#!/bin/bash

function get_test_cases {
    local my_list=( testcase1 )
    echo "${my_list[@]}"
}
function testcase1 {

./mqtt-producer &
pId=$!
echo "$pId"
#starting mosquitto_sub in background and copying logs into temp file
mosquitto_sub -t "abc123" > /tmp/test.log & pId1=$!
sleep 5
curl -d "{\"message\": \"hello world\"}" http://localhost:9096/test
sleep 5
var=$(cat /tmp/test.log)
echo $var

#killing process
kill -9 $pId
kill -9 $pId1
actualValue="{\"message\":\"hello world\"}"
echo $actualValue
if [ "$var" == "$actualValue" ] 
        then 
            echo "PASS"
            
        else
            echo "FAIL"
            
    fi
	rm -f /tmp/test1.log	
}