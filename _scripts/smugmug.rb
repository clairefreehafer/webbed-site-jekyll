require 'uri'
require 'net/http'
require 'json'
require 'yaml'

module Smugmug
  API_HOST = 'https://api.smugmug.com'
  API_KEY = YAML.load_file('./_creds.yml')['SMUGMUG_API_KEY']
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

  def Smugmug.fetch(uri_string)
    uri = URI(uri_string)
    response = Net::HTTP.get_response(uri, { 'Accept' => 'application/json' })

    case response
      when Net::HTTPRedirection
        redirect_url = "#{API_HOST}#{response['location']}"
        fetch(redirect_url)
      when Net::HTTPSuccess
        JSON.parse(response.body)
      else
        puts "❌ something went wrong fetching #{uri_string}"
        puts response.value
    end
  end
end