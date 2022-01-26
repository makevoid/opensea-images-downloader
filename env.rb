require "json"
require "bundler/setup"
Bundler.require :default

path = File.expand_path "../", __FILE__

OUTPUT_DIR = "#{path}/output"

PER_PAGE = 50

API_URL = "https://api.opensea.io/api/v1/assets?order_direction=desc&limit=#{PER_PAGE}&collection=%s&offset=%s"

COLLECTION_NAME = ENV["COLLECTION_NAME"]

raise "CollectionNameNotProvidedError - please specify COLLECTION_NAME (see readme)" if !COLLECTION_NAME || COLLECTION_NAME == ""

# hotfix for old macs :/
Excon.defaults[:ssl_verify_peer] = false

DATA = {}
DATA[:img_num] = 0
DATA[:offset]  = 0

opensea_api_key = ENV["OPENSEA_API_KEY"]
raise "OpenSeaAPIKeyNotProvidedError - please run the command with the OPENSEA_API_KEY=xxx specifying your OpenSea API key - this process doesn't work anymore without it." if !opensea_api_key || opensea_api_key == ""
OPENSEA_API_KEY = opensea_api_key

OPENSEA_API_HEADERS = {
  "Accept": "application/json",
  "x-api-key": OPENSEA_API_KEY,
}

Excon.defaults[:headers].delete 'User-Agent'
