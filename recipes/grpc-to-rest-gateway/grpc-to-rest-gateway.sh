#!/bin/bash

function get_test_cases {
    init ;
    local my_list=( testcase1 )
    echo "${my_list[@]}"
    clear ;
}

function init {   
    mashling-cli create -c grpc-to-rest-gateway.json -p petstore.proto -N
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
./mashling-gateway -c grpc-to-rest-gateway.json > /tmp/grpc.log 2>&1 &
pId2=$!
sleep 5
./grpc-to-rest-gateway -p 9096 -o 1 -i 2 > /tmp/client.log 2>&1
if [[ "echo $(cat /tmp/client.log)" =~ "res : pet:<id:2" ]] && [[ "echo $(cat /tmp/grpc.log)" =~ "Completed" ]]
    then
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
echo AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
cat /tmp/client.log
echo BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
cat /tmp/grpc.log
echo CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
}