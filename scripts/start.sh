#!/bin/bash

export BMP_PORT
export PORT_RANGE
export TTL
export BS_ARGS
export BS_KEY

echo "BMP port is $BMP_PORT"
echo "Port Range is $PORT_RANGE"
echo "TTL is $TTL"

/browsermob-proxy/bin/browsermob-proxy -port $BMP_PORT -proxyPortRange $PORT_RANGE -ttl $TTL

wait_untill(){
        #waits untill the proxy server doesn't comes up
        while [ 1 -eq 1 ];
        do
                echo 'Waiting for proxy to come up .....'
                resp=`curl -X GET 'http://localhost:' && $BMP_PORT && '/proxy/' 2>/dev/null`
                echo $resp | grep 'proxyList' 1>/dev/null
                [ $? -eq 0 ] && echo 'Proxy is up now ! ' && break
                sleep 5
        done
}

echo "BrowserStack argument is $BS_ARGS"
echo "BrowserStack key is $BS_KEY"

/usr/local/bin/BrowserStackLocal $BS_ARGS $BS_KEY