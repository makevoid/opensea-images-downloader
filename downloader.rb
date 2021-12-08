require_relative "env"

DATA = {}
DATA[:img_num] = 0
DATA[:offset] = 0

def fetch_batch(offset: 0)
  offset *= PER_PAGE
  url = API_URL % [COLLECTION_NAME, offset]
  # puts url
  puts url
  res = Excon.get url
  res = JSON.parse res.body
  exit if assets_empty? res: res
  image_urls = fetch_image_urls res: res
  download_images image_urls: image_urls
  DATA[:offset] += 1
  fetch_batch offset: DATA[:offset]
rescue Excon::Error::Timeout, Errno::ECONNRESET
  puts "Got timeout - waiting for 10 seconds"
  sleep 10
  retry
end

def assets_empty?(res:)
  assets = res.fetch "assets"
  assets.empty?
end

def fetch_image_urls(res:)
  assets = res.fetch "assets"
  image_urls = []
  assets.each do |asset|
    image_url = asset.fetch "image_original_url"
    image_url = asset.fetch "image_url" unless image_url
    image_urls.push image_url
  end
  image_urls
end

def download_images(image_urls:)
  image_urls.each do |image_url|
    download_image image_url: image_url unless image_url == ""
  end
end

def download_image(image_url:)
  URI image_url # uri check
  res = Excon.get image_url
  image_binary = res.body
  file_ext = File.extname image_url
  file_ext = ".png" if file_ext == ""
  image_num = DATA[:img_num]
  path = "#{OUTPUT_DIR}/#{image_num}#{file_ext}"
  File.open(path, "wb") { |f| f.write image_binary }
  DATA[:img_num] += 1
rescue Excon::Error::Timeout, Errno::ECONNRESET
  puts "Got timeout - waiting for 10 seconds"
  sleep 10
  retry
rescue URI::InvalidURIError
  puts "invalid uri - #{image_url.inspect}"
rescue ArgumentError
  puts "invalid uri? - #{image_url.inspect}"
end


def main
  fetch_batch
end

main
