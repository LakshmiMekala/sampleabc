#!/bin/bash

function get_test_cases {
    # init ;
    local my_list=( testcase1 testcase2 )
    echo "${my_list[@]}"
    # clear ;
}

function init {
    go get google.golang.org/grpc
    mashling-cli create -c grpc-to-grpc-gateway.json -p petstore.proto -N
    if [[ "$OSTYPE" == "darwin"* ]] ;then
        mv mashling-custom/mashling-gateway-darwin-amd64 mashling-custom/mashling-gateway
        cp mashling-custom/mashling-gateway .
    elif [[ "$OSTYPE" == "msys"* ]] ;then
        mv mashling-custom/mashling-gateway-windows-amd64.exe mashling-custom/mashling-gateway.exe
        cp mashling-custom/mashling-gateway.exe .
    elif [[ "$OSTYPE" == "linux-gnu"* ]] ;then
        mv mashling-custom/mashling-gateway-linux-amd64 mashling-custom/mashling-gateway
        cp mashling-custom/mashling-gateway .
    fi 
}

function clear {
    rm -rf mashilng-custom
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
/tmp/grpc1.log
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
/tmp/grpc2.log
}