#!/bin/bash 

function get_test_cases {
    local my_list=( testcase1 testcase2 )
    echo "${my_list[@]}"
}
function testcase1 {
$GOPATH/src/github.com/TIBCOSoftware/mashling-gateway/bin/mashling-gateway -config rest-conditional-gateway.json &
pId=$!
sleep 15
response=$(curl --request GET http://localhost:9096/pets/24 --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] 
    then 
        echo "PASS"
    else
        echo "FAIL"
fi
}
function testcase2 {
$GOPATH/src/github.com/TIBCOSoftware/mashling-gateway/bin/mashling-gateway -config rest-conditional-gateway.json &
pId=$!
sleep 15
response=$(curl -X PUT "http://localhost:9096/pets" -H "accept: application/xml" -H "Content-Type: application/json" -d '{"category":{"id":16,"name":"Animals"},"id":16,"name":"SPARROW","photoUrls":["string"],"status":"sold","tags":[{"id":0,"name":"string"}]}' --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] 
    then 
        echo "PASS"
    else
        echo "FAIL"
fi
}