#!/bin/bash 

function get_test_cases {
    local my_list=( testcase1 testcase2 )
    echo "${my_list[@]}"
}
function testcase1 {
./rest-conditional-gateway &
pId=$!
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
./rest-conditional-gateway &
pId=$!
response=$(curl --request GET http://localhost:9096/pets/24 --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] 
    then 
        echo "PASS"
    else
        echo "FAIL"
fi
}