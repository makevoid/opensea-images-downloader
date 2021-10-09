require "json"
require "bundler/setup"
Bundler.require :default

path = File.expand_path "../", __FILE__

OUTPUT_DIR = "#{path}/output"

API_URL = "https://api.opensea.io/api/v1/assets?order_direction=desc&limit=50&collection=%s&offset=%s"

COLLECTION_NAME = ENV["COLLECTION_NAME"]

raise "CollectionNameNotFoundError - please specify COLLECTION_NAME (see readme)" if !COLLECTION_NAME || COLLECTION_NAME == ""

# hotfix for old macs :/
Excon.defaults[:ssl_verify_peer] = false
