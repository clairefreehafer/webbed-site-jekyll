require 'yaml'
require 'date'
require 'uri'
require 'net/http'
require 'json'

SMUGMUG_API_KEY = YAML.load_file('./_creds.yml')['SMUGMUG_API_KEY']

game = ARGV[0]
file = ARGV[1]

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

# TODO: for alt-text, perhaps we can add it after the fact to the yaml,
# and then add a step here that checks for that pre-existing, and
# preserves it if possible. this could tie into something that also
# checks if a file needs to be updated at all (but that seems hard)
# also should do this for has_border and other site-specific image properties

games = ['new_horizons', 'new_leaf']

# check game and file are valid
if not games.include? game then
  puts "❌ invalid game!"
end

unless file.include? '.md'
  file = "#{file}.md"
end

page_config = YAML.load_file("./_animal_crossing/#{game}/#{file}", permitted_classes: [Date])
output_array = [];
album_key = page_config['album_key']

if album_key then
  images = fetch(generate_api_url(album_key, 'album', 'images'))['Response']['AlbumImage']

  for image in images do
    largest_image_uri = image['Uris']['LargestImage']['Uri']

    image_url = fetch("https://api.smugmug.com#{largest_image_uri}?APIKey=#{SMUGMUG_API_KEY}")['Response']['LargestImage']['Url']

    data_to_save = {
      'src' => image_url,
      'alt' => '',
      'title' => image['Title'],
      'caption' => image['Caption'],
      # TODO: need to fix AC dates from scratch pretty much x_x
      # 'date' => DateTime.parse(image['DateTimeOriginal']).strftime('%F %T'),
      'tags' => image['KeywordArray']
    }

    output_array.push(data_to_save)
  end
end

if output_array.length > 0 then
  data_file = file.sub! '.md', '.yml'

  output_yaml = output_array.to_yaml
  # remove quotes around dates x_x
  output_yaml = output_yaml.gsub(/(?<!')'(?=[\d\-:\s ]+)/, '')

  File.write("./_data/animal_crossing/#{game}/#{data_file}", output_yaml)

  puts "✅ generated #{game}/#{data_file}"
else
  puts "❗️ no data generated for #{game}/#{file}"
end

# this is too much every time
def update_all_files()
  games = Dir.entries('./_animal_crossing').select { |game| game[0] != '.'}

  for game in games do
    puts game
    files = Dir.entries("./_animal_crossing/#{game}").select { |file| file[0] != '.' }

    for file in files do
      page_config = YAML.load_file("./_animal_crossing/#{game}/#{file}", permitted_classes: [Date])
      output_array = [];
      album_key = page_config['album_key']

      if album_key then
        images = fetch(generate_api_url(album_key, 'album', 'images'))['Response']['AlbumImage']

        for image in images do
          largest_image_uri = image['Uris']['LargestImage']['Uri']

          image_url = fetch("https://api.smugmug.com#{largest_image_uri}?APIKey=#{SMUGMUG_API_KEY}")['Response']['LargestImage']['Url']

          puts image

          data_to_save = {
            'src' => image_url,
            'alt' => '',
            'title' => image['Title'],
            'caption' => image['Caption'],
            # TODO: need to fix AC dates from scratch pretty much x_x
            # 'date' => DateTime.parse(image['DateTimeOriginal']).strftime('%F %T'),
            'tags' => image['KeywordArray']
          }

          output_array.push(data_to_save)
        end
      end

      if output_array.length > 0 then
        data_file = file.sub! '.md', '.yml'

        output_yaml = output_array.to_yaml
        # remove quotes around dates x_x
        output_yaml = output_yaml.gsub(/(?<!')'(?=[\d\-:\s ]+)/, '')

        File.write("./_data/animal_crossing/#{game}/#{data_file}", output_yaml)

        puts "✅ generated #{game}/#{data_file}"
      else
        puts "❗️ no data generated for #{game}/#{file}"
      end
    end

  end
end

