require "uri"
require "net/http"
require "json"
require "yaml"
require "oauth"

module Smugmug
  creds = YAML.load_file("./_creds.yml")

  API_HOST = "https://api.smugmug.com"
  API_KEY = creds["SMUGMUG_API_KEY"]
  API_KEY_SECRET = creds["SMUGMUG_API_KEY_SECRET"]
  ACCESS_TOKEN = creds["SMUGMUG_ACCESS_TOKEN"]
  ACCESS_TOKEN_SECRET = creds["SMUGMUG_ACCESS_TOKEN_SECRET"]
  # keys smugmug uses for these metadata values
  TITLE = "Title"
  CAPTION = "Caption"
  TAGS = "KeywordArray"

  def Smugmug.generate_api_url(key, type, uri)
    if uri then
      "#{API_HOST}/api/v2/#{type}/#{key}!#{uri}?APIKey=#{API_KEY}"
    else
      "#{API_HOST}/api/v2/#{type}/#{key}?APIKey=#{API_KEY}"
    end
  end

  def Smugmug.get(uri_string)
    uri = URI(uri_string)
    response = Net::HTTP.get_response(uri, { "Accept" => "application/json" })

    case response
      when Net::HTTPMovedPermanently
        redirect_url = "#{API_HOST}#{response["location"]}"
        get(redirect_url)
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        puts "❌ something went wrong fetching #{uri_string}"
        puts response.value
    end
  end

  def Smugmug.patch(image_key, body)
    oauth_consumer = OAuth::Consumer.new(API_KEY, API_KEY_SECRET, site: API_HOST)
    access_token = OAuth::AccessToken.new(oauth_consumer, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

    # without the `-1`, smugmug returns PermenentlyMoved with the new location including the key + `-1`
    # not 100% sure if this is true for all keys, but if this breaks, that's probably why.
    response = access_token.patch("/api/v2/image/#{image_key}-1", body.to_json, { "Content-Type" => "application/json" })

    case response
      when Net::HTTPSuccess
        puts "✅ smugmug metadata successfully updated"
      else
        puts "❌ something went wrong updating #{image_key} with #{body.to_json}"
        puts response.value
    end
  end
end