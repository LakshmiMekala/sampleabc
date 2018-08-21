#!/bin/bash

function get_test_cases {
    local my_list=( testcase1 testcase2 )
    echo "${my_list[@]}"
}

function testcase1 {
./mashling-gateway -c grpc-to-grpc-gateway.json > /tmp/grpc1.log 2>&1 &
pId2=$!
sleep 5
go run main.go -server > /tmp/server1.log 2>&1 &
pId=$!
sleep 5
go run main.go -client -port 9096 -method pet -param 2 > /tmp/client1.log 2>&1 &
pId1=$!
sleep 5
if [[ "echo $(cat /tmp/client1.log)" =~ "res : pet:<id:2" ]] && [[ "echo $(cat /tmp/grpc1.log)" =~ "Completed" ]]
    then
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
kill -9 $pId1
var=$(ps --ppid $pId)
pId7=$(echo $var | awk '{print $5}')
kill -9 $pId7
cat /tmp/grpc1.log
cat /tmp/server1.log
cat /tmp/client1.log
}

function testcase2 {
./mashling-gateway -c grpc-to-grpc-gateway.json > /tmp/grpc2.log 2>&1 &
pId2=$!
sleep 5
go run main.go -server > /tmp/server2.log 2>&1 &
pId=$!
sleep 5
go run main.go -client -port 9096 -method user -param user2 > /tmp/client2.log 2>&1 &
pId1=$!
sleep 5
if [[ "echo $(cat /tmp/client2.log)" =~ "res : user:<id:2 username" ]] && [[ "echo $(cat /tmp/grpc2.log)" =~ "Completed" ]]
    then
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
kill -9 $pId1
var=$(ps --ppid $pId)
pId7=$(echo $var | awk '{print $5}')
kill -9 $pId7
cat /tmp/grpc2.log
cat /tmp/server2.log
cat /tmp/client2.log
}