require_relative "env"

DATA = {}
DATA[:img_num] = 0
DATA[:offset] = 0

def fetch_batch(offset: 0)
  url = API_URL % [COLLECTION_NAME, offset]
  # puts url
  res = Excon.get url
  res = JSON.parse res.body
  exit if assets_empty? res: res
  image_urls = fetch_image_urls res: res
  download_images image_urls: image_urls
  DATA[:offset] += 1
  fetch_batch offset: DATA[:offset]
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
    download_image image_url: image_url
  end
end

def download_image(image_url:)
  # puts image_url
  res = Excon.get image_url
  image_binary = res.body
  file_ext = File.extname image_url
  file_ext = ".png" unless file_ext
  image_num = DATA[:img_num]
  File.write "#{OUTPUT_DIR}/#{image_num}#{file_ext}", image_binary
  DATA[:img_num] += 1
end


def main
  fetch_batch
end

main
