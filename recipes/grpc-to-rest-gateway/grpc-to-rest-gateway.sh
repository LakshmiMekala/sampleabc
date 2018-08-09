#!/bin/bash

function get_test_cases {
    init ;
    local my_list=( testcase1 )
    echo "${my_list[@]}"
    clear ;
}

function init {
    pushd $GOPATH/src/github.com/TIBCOSoftware/mashling
    git checkout feature-grpc-support
    go run build.go build
    popd
    go get -u github.com/golang/protobuf/protoc-gen-go
    apt-get install unzip > /tmp/log.log 2>&1
    PROTOC_ZIP=protoc-3.3.0-linux-x86_64.zip
    curl -OL https://github.com/google/protobuf/releases/download/v3.3.0/$PROTOC_ZIP
    sudo unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
    rm -f $PROTOC_ZIP
    mashling-cli create -c grpc-to-rest-gateway.json -p petstore.proto -N
    if [[ "$OSTYPE" == "darwin"* ]] ;then
        mv mashling-custom/mashling-gateway-darwin-amd64 mashling-custom/mashling-gateway
    elif [[ "$OSTYPE" == "msys"* ]] ;then
        mv mashling-custom/mashling-gateway-windows-amd64.exe mashling-custom/mashling-gateway.exe
    elif [[ "$OSTYPE" == "linux-gnu"* ]] ;then
        mv mashling-custom/mashling-gateway-linux-amd64 mashling-custom/mashling-gateway
    fi
    cp mashling-custom/mashling-gateway . 
}

function clear {
    rm -rf mashilng-custom
    pushd $GOPATH/src/github.com/TIBCOSoftware/mashling
    git checkout master
    go run build.go build
    popd
}

function testcase1 {
./mashling-gateway -c grpc-to-rest-gateway.json > /tmp/grpc.log 2>&1 &
pId2=$!
sleep 5
grpc-to-rest-gateway -p 9096 -o 1 -i 2 > /tmp/client.log 2>&1
if [[ "echo $(cat /tmp/client.log)" =~ "res : pet:<id:2" ]] && [[ "echo $(cat /tmp/grpc.log)" =~ "Completed" ]]
    then
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
}