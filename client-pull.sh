#!/bin/bash

# $1 is Collection name and tag
# $2 is output directory
# $3 is environment name 
# $4 set this as "--plain-http=true" if needed

rm -Rf $2/build_*

./client pull $1 $2 --attributes "server=1" $4
./client pull $1 $2 --attributes "env=$3" $4

chmod +x ./$2/caddy
./$2/caddy file-server -listen :8081 -root $2/build_*/