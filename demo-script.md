# ORAS Community Meeting - UOR Demo

## First swap out the dev index.html
`cp  index.html push/build_local/`

## Publish the Collection 
`./client-push.sh localhost:5001/oras:v1 --plain-http=true`

## View the Collection Manifest
`curl localhost:5001/v2/oras/manifests/v1 | jq`

## Pull the dev Site
`./client-pull.sh localhost:5001/oras:v1 demo dev --plain-http=true`

## Switch to browser and verify site has very few features enabled

## Pull the prod Site
`./client-pull.sh localhost:5001/oras:v1 demo prod --plain-http=true`

## Verify prod site in browser
