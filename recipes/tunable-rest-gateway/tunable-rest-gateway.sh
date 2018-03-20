#!/bin/bash 

function get_test_cases {
    local my_list=( testcase1 testcase2 )
    echo "${my_list[@]}"
}
function testcase1 {
		export API_CONTEXT=PETS
.$GOPATH/src/github.com/TIBCOSoftware/mashling-gateway/bin/mashling-gateway -config tunable-rest-gateway.json &
pId=$!
response=$(curl --request GET http://localhost:9096/id/17 --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] 
    then 
        echo "PASS"
    else
        echo "FAIL"
fi
}
function testcase2 {
export API_CONTEXT=USERS
.$GOPATH/src/github.com/TIBCOSoftware/mashling-gateway/bin/mashling-gateway -config tunable-rest-gateway.json &
pId=$!
response=$(curl --request GET http://localhost:9096/id/17 --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] 
    then 
        echo "PASS"
    else
        echo "FAIL"
fi
}