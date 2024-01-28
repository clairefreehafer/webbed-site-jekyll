require "nokogiri"

# TODO: any easier way to do this?
file = ARGV[0]
metadata_location = "/Volumes/Freehafer 2/My Stuff/Raw/#{file}.xmp"

metadata = File.open(metadata_location) { |f| Nokogiri::XML::parse(f) }

# TODO: figure out how to get .search working T_T
rdfDescription = metadata.root.elements.first.elements.first

tags = []
title = nil
caption = nil

rdfDescription.elements.each do |node|
  if node.name == "subject"
    node.elements.first.elements.each do |tag_node|
      tags.push(tag_node.text)
    end
  elsif node.name == "title"
    title = node.elements.first.elements.first.text
  elsif node.name == "UserComment"
    caption = node.elements.first.elements.first.text
  end
end

puts title
puts caption
puts tags