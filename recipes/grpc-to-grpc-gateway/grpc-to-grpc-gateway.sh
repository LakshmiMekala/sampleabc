#!/bin/bash

function get_test_cases {
    local my_list=( testcase1 )
    echo "${my_list[@]}"
}

function testcase1 {
go get -u github.com/golang/protobuf/protoc-gen-go
apt-get install unzip > /tmp/log.log 2>&!
wget https://github.com/google/protobuf/releases/download/v3.6.1/protoc-3.6.1-linux-x86_64.zip > /tmp/log.log 2>&!
unzip protoc-3.6.1-linux-x86_64.zip
export PATH=$PATH:/bin
pushd $GOPATH/src/github.com/TIBCOSoftware/mashling
git checkout feature-grpc-support
go run build.go build
popd
mashling-cli grpc generate -p petstore.proto
pushd $GOPATH/src/github.com/TIBCOSoftware/mashling-recipes/recipes/grpc-to-grpc-gateway
cd samplegrpcserver
go install ./...
cd ../samplegrpcclient
go install ./... 
cd ..

pushd $GOPATH/src/github.com/TIBCOSoftware/mashling
go run build.go build
popd
samplegrpcserver -port 9000 &
pId=$!
samplegrpcserver -port 9001 &
pId1=$!
mashling-gateway -c grpc-to-grpc-gateway.json > /tmp/grpc.log 2>&1 &
pId2=$!
sleep 5
samplegrpcclient -p 9096 -o 1 -i 2 > /tmp/client.log 2>&1
popd
if [[ "echo $(cat /tmp/client.log)" =~ "res : pet:<id:2" ]] && [[ "echo $(cat /tmp/grpc.log)" =~ "Completed" ]]
    then
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
kill -15 $pId $pId1
mashling-cli grpc clean -p petstore.proto
}