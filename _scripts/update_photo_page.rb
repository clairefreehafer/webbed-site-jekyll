require 'yaml'
require 'date'
require 'time'
require 'uri'
require 'net/http'
require 'json'
require_relative 'smugmug'

games = {
  'animal_crossing' => ['new_horizons', 'new_leaf'],
  'zelda' => ['breath_of_the_wild', 'tears_of_the_kingdom']
}

section = ARGV[0]

if section == 'photography' then
  file = ARGV[1]
  file_path = "#{section}/#{file}"
elsif section === 'animal_crossing' or section === 'zelda' then
  game = ARGV[1]
  file = ARGV[2]

  unless games[section].include? game
    puts "❌ #{game} is not a valid game!"
    exit
  end

  file_path = "#{section}/#{game}/#{file}"
else
  puts "❌ section #{section} not recognized!"
  exit
end

if file.include? '.md' then
  puts "❌ please don't include the file extension in #{file}"
  exit
end

# check if we already have a data file
if File.exist?("./_data/#{file_path}.yml")
  data = YAML.load_file("./_data/#{file_path}.yml", permitted_classes: [Date, Time])
  puts "➡️  existing data found for #{file_path}"
end

page_config = YAML.load_file("./_#{file_path}.md", permitted_classes: [Date, Time])
output_array = [];
album_key = page_config['album_key']

if album_key then
  images = Smugmug.fetch(Smugmug.generate_api_url(album_key, 'album', 'images'))['Response']['AlbumImage']

  if not images
    puts "❌ no images found for #{file_path}"
    exit
  end

  for image in images do
    largest_image_uri = image['Uris']['LargestImage']['Uri']

    image_url = Smugmug.fetch("#{Smugmug::API_HOST}#{largest_image_uri}?APIKey=#{Smugmug::API_KEY}")['Response']['LargestImage']['Url']

    if data then
      existing_data = data.find { |img_data| img_data["src"] == image_url }
    end

    alt = (existing_data and existing_data['alt']) ? existing_data['alt'] : ''

    data_to_save = {
      'src' => image_url,
      'alt' => alt,
      'title' => image['Title'],
      'caption' => image['Caption'],
      'tags' => image['KeywordArray']
    }

    # don't care about date for zelda photos
    unless section == 'zelda'
      if image['DateTimeOriginal'] then
        data_to_save['date'] = DateTime.parse(image['DateTimeOriginal']).strftime('%F %T')
      else
        # X__X animal crossing photos don't have DateTimeOriginal for some reason...
        filename = image['FileName']
        filename[10] = 'T'
        filename[13] = ':'
        filename[16] = ':'
        data_to_save['date'] = DateTime.parse(filename).strftime('%F %T')
      end
    end

    if existing_data and existing_data['extras'] then
      data_to_save['extras'] = existing_data['extras']
    end

    output_array.push(data_to_save)
  end
else
  puts "❗️ #{file} is missing an album key!"
  exit
end

if output_array.length > 0 then
  output_yaml = output_array.to_yaml
  # remove quotes around dates x_x
  output_yaml = output_yaml.gsub(/(?<!')'(?=[\d\-:\s ]+)/, '')

  File.write("./_data/#{file_path}.yml", output_yaml)

  puts "✅ generated _data/#{file_path}.yml"
else
  puts "❗️ no data generated for #{file_path}"
end
