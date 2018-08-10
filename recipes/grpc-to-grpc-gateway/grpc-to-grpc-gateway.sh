#!/bin/bash

function get_test_cases {
    init ;
    local my_list=( testcase1 )
    echo "${my_list[@]}"
    clear ;
}

function init {    
    go get -u github.com/golang/protobuf/protoc-gen-go
    apt-get install unzip > /tmp/log.log 2>&1
    curl -OL https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip > /tmp/test5.log
    sudo unzip -o protoc-3.3.0-linux-x86_64.zip -d /usr/local bin/protoc
    rm -f $PROTOC_ZIP
    cd samplegrpcserver
    go install ./...
    cd ../samplegrpcclient
    go install ./... 
    cd ..
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
./samplegrpcserver -port 9000 &
pId=$!
./samplegrpcserver -port 9001 &
pId1=$!
./mashling-gateway -c grpc-to-grpc-gateway.json > /tmp/grpc.log 2>&1 &
pId2=$!
sleep 5
samplegrpcclient -p 9096 -o 1 -i 2 > /tmp/client.log 2>&1
if [[ "echo $(cat /tmp/client.log)" =~ "res : pet:<id:2" ]] && [[ "echo $(cat /tmp/grpc.log)" =~ "Completed" ]]
    then
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
kill -15 $pId $pId1
}