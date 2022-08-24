#!/bin/bash

# $1 is the Collection name and tag
# $2 set this as "--plain-http=true" if needed

./client push --dsconfig=dataset-config.yaml push $1 $2