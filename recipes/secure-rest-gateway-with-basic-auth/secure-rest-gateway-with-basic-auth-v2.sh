#!/bin/bash 

function get_test_cases {
    local my_list=( testcase1 testcase2 testcase3 )
    echo "${my_list[@]}"
}
function testcase1 {

cat > $GOPATH/pswd.txt <<EOL
foo:bar
tom:jerry
EOL

export BASIC_AUTH_FILE=$GOPATH/pswd.txt	
$GOPATH/src/github.com/TIBCOSoftware/mashling-gateway/bin/mashling-gateway -env-var-name foo:5VvmQnTXZ10wGZu_Gkjb8umfUPIOQTQ3p1YFadAWTl8=:6267beb3f851b7fee14011f6aa236556f35b186a6791b80b48341e990c367643 -config secure-rest-gateway-with-basic-auth.json &
pId=$!
sleep 15
response=$(curl --request GET http://foo:bar@localhost:9096/pets/3 --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] 
    then 
        echo "PASS"
    else
        echo "FAIL"
fi
}
function testcase2 {

cat > $GOPATH/pswd.txt <<EOL
foo:bar
tom:jerry
EOL

export BASIC_AUTH_FILE=$GOPATH/pswd.txt	

$GOPATH/src/github.com/TIBCOSoftware/mashling-gateway/bin/mashling-gateway -env-var-name foo:5VvmQnTXZ10wGZu_Gkjb8umfUPIOQTQ3p1YFadAWTl8=:6267beb3f851b7fee14011f6aa236556f35b186a6791b80b48341e990c367643 -config secure-rest-gateway-with-basic-auth.json &
pId=$!
sleep 15
response=$(curl --request GET http://foo:badpass@localhost:9096/pets/3 --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 403  ] 
    then 
        echo "PASS"
    else
        echo "FAIL"
fi
}


function testcase3 {

cat > $GOPATH/pswd.txt <<EOL
foo:bar
tom:jerry
EOL

export BASIC_AUTH_FILE=$GOPATH/pswd.txt	

$GOPATH/src/github.com/TIBCOSoftware/mashling-gateway/bin/mashling-gateway -env-var-name foo:15VvmQnTXZ10wGZu_Gkjb8umfUPIOQTQ3p1YFadAWTl8=:6267beb3f851b7fee14011f6aa236556f35b186a6791b80b48341e990c367643 -config secure-rest-gateway-with-basic-auth.json &
pId=$!
sleep 15
response=$(curl --request GET http://tom:jerry@localhost:9096/pets/3 --write-out '%{http_code}' --silent --output /dev/null)
kill -9 $pId
if [ $response -eq 200  ] 
    then 
        echo "PASS"
    else
        echo "FAIL"
fi
}