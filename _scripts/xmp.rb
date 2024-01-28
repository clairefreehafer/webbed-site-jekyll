require "nokogiri"

metadata = File.open("./20140112_140131.jpg.xmp") { |f| Nokogiri::XML::parse(f) }

# TODO: figure out a better way to grab this node
rdfDescription = metadata.root.elements.first.elements.first
date = rdfDescription.attribute("DateTimeOriginal")
