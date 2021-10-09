require_relative "env"

def fetch_batch(offset: 0)
  url = API_URL % [COLLECTION_NAME, offset]
  res = Excon.get url
  res = JSON.parse res.body
  exit if assets_empty? res: res
  image_urls = fetch_image_urls res: res
  download_images image_urls: image_urls
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
    image_urls.push image_url
  end
  image_urls
end

def download_images(image_urls:)

end
