#!/bin/bash

function get_test_cases {
    local my_list=( testcase1 )
    echo "${my_list[@]}"
}

function testcase1 {
go get -u github.com/golang/protobuf/protoc-gen-go
apt-get install unzip > /tmp/log.log 2>&1
PROTOC_ZIP=protoc-3.3.0-linux-x86_64.zip
curl -OL https://github.com/google/protobuf/releases/download/v3.3.0/$PROTOC_ZIP
sudo unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
rm -f $PROTOC_ZIP
pushd $GOPATH/src/github.com/TIBCOSoftware/mashling
git checkout feature-grpc-support
go run build.go build
popd
mashling-cli grpc generate -p petstore.proto
pushd $GOPATH/src/github.com/TIBCOSoftware/mashling-recipes/recipes/grpc-to-rest-gateway
go install ./...
pushd $GOPATH/src/github.com/TIBCOSoftware/mashling
go run build.go build
popd
mashling-gateway -c grpc-to-rest-gateway.json > /tmp/grpc.log 2>&1 &
pId2=$!
sleep 5
grpc-to-rest-gateway -p 9096 -o 1 -i 2 > /tmp/client.log 2>&1
popd
if [[ "echo $(cat /tmp/client.log)" =~ "res : pet:<id:2" ]] && [[ "echo $(cat /tmp/grpc.log)" =~ "Completed" ]]
    then
        echo "PASS"
    else
        echo "FAIL"
fi        
kill -9 $pId2
mashling-cli grpc clean -p petstore.proto
}