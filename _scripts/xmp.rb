require "nokogiri"

metadata = File.open("./20140112_140131.jpg.xmp") { |f| Nokogiri::XML::parse(f) }

# TODO: figure out how to get .search working T_T
rdfDescription = metadata.root.elements.first.elements.first

rdfDescription.elements.each do |node|
  if node.name == "subject"
    puts node.elements.first.elements.first.text
  end
end