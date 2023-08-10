require 'yaml'
require 'date'
require 'uri'
require 'net/http'
require 'json'

SMUGMUG_API_KEY = YAML.load_file('./_creds.yml')['SMUGMUG_API_KEY']

def generate_api_url(key, type, uri)
  if uri then
    "https://api.smugmug.com/api/v2/#{type}/#{key}!#{uri}?APIKey=#{SMUGMUG_API_KEY}"
  else
    "https://api.smugmug.com/api/v2/#{type}/#{key}?APIKey=#{SMUGMUG_API_KEY}"
  end
end

def fetch(uri_string)
  uri = URI(uri_string)
  response = Net::HTTP.get_response(uri, { 'Accept' => 'application/json' })

  case response
    when Net::HTTPRedirection
      redirect_url = "https://api.smugmug.com#{response['location']}"
      fetch(redirect_url)
    when Net::HTTPSuccess
      JSON.parse(response.body)
    else
      puts "something went wrong fetching #{uri_string}"
      puts response.value
  end
end

fields_to_grab = {
  'Caption' => 'caption',
  'DateTimeOriginal' => 'date',
  'KeywordArray' => 'tags',
  'Title' => 'title'
}

tag_to_album_mapping = {
  'dogs' => 'ngSG5M'
}

files = Dir.entries('./_photography').select { |file| file[0] != '.'}

for file in files do
  page_config = YAML.load_file("./_photography/#{file}", permitted_classes: [Date])
  output_array = []

  if page_config['tag'] then
    # if gathering by a tag
    tag = page_config['tag']

    tag_album = fetch(generate_api_url(tag_to_album_mapping[tag], 'album', 'images'))

    puts tag_album['Response']['AlbumImage'][0]

  elsif page_config['images'] then
    # TODO: look into smugmug's multiget
    for image in page_config['images'] do
      if (image['key']) then
        image_url = fetch(generate_api_url(image['key'], 'image', 'largestimage'))['Response']['LargestImage']['Url']
        image_data = fetch(generate_api_url(image['key'], 'image', nil))['Response']['Image']

        data_to_save = {
          'src' => image_url,
          'alt' => image['alt']
        }

        fields_to_grab.each do |smugmug_key, our_key|
          value = ''
          if smugmug_key == 'DateTimeOriginal' then
            # dates are UTC
            value = DateTime.parse(image_data[smugmug_key]).strftime('%F %T')
          else
            value = image_data[smugmug_key]
          end

          data_to_save[our_key] = value
        end

        output_array.push(data_to_save)

      else
        puts "an image in #{file} is missing a smugmug key."
      end

    end
  end

  data_file = file.sub! '.md', '.yml'

  output_yaml = output_array.to_yaml
  # remove quotes around dates x_x
  output_yaml = output_yaml.gsub(/(?<!')'(?=[\d\-:\s ]+)/, '')

  File.write("./_data/photography/#{data_file}", output_yaml)
end

