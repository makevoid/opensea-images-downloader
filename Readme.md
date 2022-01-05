# opensea-images-downloader

Script to download all the images from an opensea collection using the OpenSea API

### Prerequisites

I recommend you run the docker version as you don't have to have Ruby and Bundler installed.

#### Docker version

- Docker and Docker compose installed (https://docs.docker.com/get-docker/ - https://docs.docker.com/compose/install/)

#### System version (non-docker)

- Ruby and Bundler installed (`gem install bundler`)


### Running in docker

To run in docker (easiest / recommended mode) just clone the project, cd into it and run this command:

    docker-compose run -e COLLECTION_NAME=boredapeyachtclub makevoid/opensea_downloader

Check the `output` directory which will contain the downloaded images.


### Installation (non-docker)

clone and cd into the directory

make sure you have ruby and bundler installed (`ruby -v`, `gem i bundler`)

run:

    bundle

### Running (non-docker)

execute this command to start scraping:

    rake COLLECTION_NAME="..."


(COLLECTION_NAME is the opensea collection name all lowercase, with spaces instead of dashes, as it appears in the URL)


---

enjoy

@makevoid
