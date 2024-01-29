require "nokogiri"
require_relative "smugmug"

module XMP
  def XMP.get_xmp_metadata(path)
    metadata_location = "/Volumes/Freehafer 2/My Stuff/Raw/#{path}.xmp"
    metadata = File.open(metadata_location) { |f| Nokogiri::XML::parse(f) }

    # TODO: figure out how to get .search working T_T
    rdfDescription = metadata.root.elements.first.elements.first

    parsed_metadata = {}

    rdfDescription.elements.each do |node|
      if node.name == "subject" # tags
        parsed_metadata[Smugmug::TAGS] = []
        node.elements.first.elements.each do |tag_node|
          parsed_metadata[Smugmug::TAGS].push(tag_node.text)
        end
      elsif node.name == "title"
        parsed_metadata[Smugmug::TITLE] = node.elements.first.elements.first.text
      elsif node.name == "UserComment"
        parsed_metadata[Smugmug::CAPTION] = node.elements.first.elements.first.text
      end
    end

    return parsed_metadata
  end
end
