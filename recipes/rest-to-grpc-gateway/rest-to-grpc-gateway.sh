#!/bin/bash

function get_test_cases {
    local my_list=( testcase1 testcase2 )
    echo "${my_list[@]}"
}

function testcase1 {
./mashling-gateway -c rest-to-grpc-gateway.json > /tmp/grpc1.log 2>&1 &
pId2=$!
sleep 5
go run main.go -server > /tmp/server1.log 2>&1 &
pId=$!
sleep 5
response=$(curl --request GET http://localhost:9096/pets/PetById/2 --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] && [[ "echo $(cat /tmp/grpc1.log)" =~ "Completed" ]]
    then 
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
var=$(ps --ppid $pId)
pId7=$(echo $var | awk '{print $5}')
kill -9 $pId7
}

function testcase2 {
./mashling-gateway -c rest-to-grpc-gateway.json > /tmp/grpc2.log 2>&1 &
pId2=$!
sleep 5
go run main.go -server > /tmp/server2.log 2>&1 &
pId=$!
sleep 5
response=$(curl --request GET http://localhost:9096/users/UserByName/user2 --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] && [[ "echo $(cat /tmp/grpc2.log)" =~ "Completed" ]]
    then 
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
var=$(ps --ppid $pId)
pId7=$(echo $var | awk '{print $5}')
kill -9 $pId7
}

function testcase3 {
./mashling-gateway -c rest-to-grpc-gateway.json > /tmp/grpc3.log 2>&1 &
pId2=$!
sleep 5
go run main.go -server > /tmp/server3.log 2>&1 &
pId=$!
sleep 5
response=$(curl -X PUT "http://localhost:9096/pets/PetById" -H "accept: application/xml" -H "Content-Type: application/json" -d '{"id":3}' --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] && [[ "echo $(cat /tmp/grpc3.log)" =~ "Completed" ]]
    then 
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
var=$(ps --ppid $pId)
pId7=$(echo $var | awk '{print $5}')
kill -9 $pId7
}


function testcase4 {
./mashling-gateway -c rest-to-grpc-gateway.json > /tmp/grpc4.log 2>&1 &
pId2=$!
sleep 5
go run main.go -server > /tmp/server4.log 2>&1 &
pId=$!
sleep 5
response=$(curl --request GET http://localhost:9096/users/UserByName?username=user3 --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] && [[ "echo $(cat /tmp/grpc4.log)" =~ "Completed" ]]
    then 
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
var=$(ps --ppid $pId)
pId7=$(echo $var | awk '{print $5}')
kill -9 $pId7
}