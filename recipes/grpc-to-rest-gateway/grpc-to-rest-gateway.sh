#!/bin/bash

function get_test_cases {
    local my_list=( testcase1 testcase2 )
    echo "${my_list[@]}"
}

function testcase1 {
./mashling-gateway -c grpc-to-rest-gateway.json > /tmp/grpc1.log 2>&1 &
pId2=$!
sleep 5
go run main.go -client -port 9096 -method pet -param 2 > /tmp/client1.log 2>&1 &
pId3=$!
sleep 5
if [[ "echo $(cat /tmp/client1.log)" =~ "res : pet:<id:2" ]] && [[ "echo $(cat /tmp/grpc1.log)" =~ "Completed" ]]
    then
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
kill -9 $pId3
}

function testcase2 {
./mashling-gateway -c grpc-to-rest-gateway.json > /tmp/grpc2.log 2>&1 &
pId2=$!
sleep 5
go run main.go -client -port 9096 -method user -param user1 > /tmp/client2.log 2>&1 &
pId3=$!
sleep 5
if [[ "echo $(cat /tmp/client2.log)" =~ "res : user:<id:1 username" ]] && [[ "echo $(cat /tmp/grpc2.log)" =~ "Completed" ]]
    then
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
kill -9 $pId3
}