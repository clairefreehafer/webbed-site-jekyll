require "yaml"
require "date"
require "time"
require "uri"
require "net/http"
require "json"
require_relative "smugmug"
require_relative "xmp"

games = {
  "animal_crossing" => ["new_horizons", "new_leaf"],
  "zelda" => ["breath_of_the_wild", "tears_of_the_kingdom"]
}

section = ARGV[0]

if section == "photography" then
  file = ARGV[1]
  file_path = "#{section}/#{file}"
elsif section === "animal_crossing" or section === "zelda" then
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

if file.include? ".md" then
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
album_key = page_config["album_key"]
missing_alt = 0
missing_path = 0

if album_key then
  images = Smugmug.get(Smugmug.generate_api_url(album_key, "album", "images"))["Response"]["AlbumImage"]

  if not images
    puts "❌ no images retrieved for #{file_path}"
    exit
  end

  for image in images do
    # TODO: fetch other image versions as well to optimize which one we are rendering
    largest_image_uri = image["Uris"]["LargestImage"]["Uri"]

    image_url = Smugmug.get("#{Smugmug::API_HOST}#{largest_image_uri}?APIKey=#{Smugmug::API_KEY}")["Response"]["LargestImage"]["Url"]

    # if we have a pre-existing data file, then find the matching entry for the current image
    if data then
      existing_data = data.find { |img_data| img_data["src"] == image_url }
    end

    # grab existing values so we don't overwrite them.
    alt = (existing_data and existing_data["alt"]) ? existing_data["alt"] : ""
    path = (existing_data and existing_data["path"]) ? existing_data["path"] : ""

    if alt.length == 0 then
      missing_alt = missing_alt + 1
    end

    # check if we have the path identified to potentially update metadata.
    if path.length > 0 then
      xmp_metadata = XMP.get_xmp_metadata(path)
      metadata_to_update = {}

      xmp_metadata.each do |property, xmp_value|
        smugmug_value = image[property]

        if (xmp_value.is_a?(Array) and xmp_value.to_set != smugmug_value.to_set) or xmp_value != smugmug_value then
          metadata_to_update[property] = xmp_value
        end
      end

      if not metadata_to_update.empty?() then
        puts "➡️  updating #{metadata_to_update.keys} on smugmug for #{path}..."
        Smugmug.patch(image["ImageKey"], metadata_to_update)
      else
        puts "➡️  no xmp metadata to update, skipping..."
      end
    else
      missing_path = missing_path + 1
    end

    data_to_save = {
      "src" => image_url,
      "alt" => alt,
      "path" => path,
      "title" => image[Smugmug::TITLE],
      "caption" => image[Smugmug::CAPTION],
      "tags" => image[Smugmug::TAGS]
    }

    # don"t care about date for zelda photos
    unless section == "zelda"
      if image["DateTimeOriginal"] then
        data_to_save["date"] = DateTime.parse(image["DateTimeOriginal"]).strftime("%F %T")
      else
        # X__X animal crossing photos don"t have DateTimeOriginal for some reason...
        filename = image["FileName"]
        filename[10] = "T"
        filename[13] = ":"
        filename[16] = ":"
        data_to_save["date"] = DateTime.parse(filename).strftime("%F %T")
      end
    end

    if existing_data and existing_data["extras"] then
      data_to_save["extras"] = existing_data["extras"]
    end

    output_array.push(data_to_save)
  end
else
  puts "❗️ #{file} is missing an album key!"
  exit
end

if missing_path > 0 then
  puts "❗️ #{missing_path} images are missing a path."
end

if missing_alt > 0 then
  puts "❗️ #{missing_alt} images are missing alt text."
end

if output_array.length > 0 then
  output_yaml = output_array.to_yaml
  # remove quotes around dates x_x
  output_yaml = output_yaml.gsub(/(?<!')'(?=[\d\-:\s ]+)/, "")

  File.write("./_data/#{file_path}.yml", output_yaml)

  puts "✅ generated _data/#{file_path}.yml"
else
  puts "❗️ no data generated for #{file_path}"
end
