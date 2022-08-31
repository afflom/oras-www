# ORAS community meeting demo

This repo is the demo of an early version of the uor client for the oras community meeting.

## Overview

This demo starts an OCI registry (go-containerregistry), pushes a UOR Collection to that registry, pulls subsets of the published content from the registry, and then serves that content (with caddy). Once the website is verified, a different subset of the published content is retrieved and served. 

## Demo instructions

You may need to tweak some ports/commands for your environment. Take a look at the demo push/pull scripts for UOR Client CLI usage. 

1. Build the demo environment
`docker build -f Containerfile . -t localhost/oras-www:demo`

2. Enter the demo
`docker run --network=host -it localhost/oras-www:demo bash`

3. Make a registry available if needed
`./registry -port 5001 &`

4. Swap out the dev index.html
`cp  index.html push/build_local/`

5. Publish the Collection 
`./client-push.sh localhost:5001/oras:v1 --plain-http=true`

6. View the Collection Manifest
`curl localhost:5001/v2/oras/manifests/v1 | jq`

7. Pull the dev Site
`./client-pull.sh localhost:5001/oras:v1 demo dev --plain-http=true`

8. Switch to browser and verify site has very few features enabled

9. Pull the prod Site
`./client-pull.sh localhost:5001/oras:v1 demo prod --plain-http=true`

10. Verify prod site in browser


# 

Source for ORAS website and documentation

Link: [oras.land](https://oras.land/)

**[The documentation can be found here](/docs/index.md).**

## Deployment

This site is deployed using [Netlify](https://www.netlify.com/)

[![Netlify Status](https://api.netlify.com/api/v1/badges/db61db6e-a953-4b02-b5fb-7f04f018b9d8/deploy-status)](https://app.netlify.com/sites/oras-project/deploys)

## Development

System requirements:

- Python 3.7+
- [Poetry](https://python-poetry.org/)

The website is an [Mkdocs](https://www.mkdocs.org/)-based documentation site, using the [Material theme](https://squidfunk.github.io/mkdocs-material/).

First install dependencies:

```
poetry install
```

Then run the development server:

```
poetry run mkdocs serve
```

The site will be available at [http://localhost:8000/](http://localhost:8000/)

## Code of Conduct

This project has adopted the [CNCF Code of Conduct](https://github.com/cncf/foundation/blob/master/code-of-conduct.md). See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for further details.

