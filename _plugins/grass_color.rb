require_relative "utils/animal_crossing"

module Jekyll
  class GrassColorTag < Liquid::Tag
    def initialize(tag_name, variables, tokens)
      super
    end

    def render(context)
      date = context['page']['date']
      if date == nil
        date = Time.now
      end

      month = date.month
      day = date.day

      shape = context['shape']

      if not shape then
        puts "❗️ please assign shape in #{context['page']['title']}"
        'NO_SHAPE_PROVIDED'
      end

      case month
      when 1
        range = "1210-0224"
      when 2
        if day <= 24 then
          range = "1210-0224"
        else
          range = "0225-0331"
        end
      when 3
        range = "0225-0331"
      when 4..6
        range = "0401-0722"
      when 7
        if day <= 22
          range = "0401-0722"
        else
          range = "0723-0915"
        end
      when 8
        range = "0723-0915"
      when 9
        if day <= 15
          range = "0723-0915"
        else
          range = "0916-0930"
        end
      when 10
        if day <= 15
          range = "1001-1015"
        elsif day <= 29
          range = "1016-1029"
        else
          range = "1030-1112"
        end
      when 11
        if day <= 12
          range = "1030-1112"
        elsif day <= 28
          range = "1113-1128"
        else
          range = "1129-1209"
        end
      when 12
        if day <= 9
          range = "1129-1209"
        else
          range = "1210-0224"
        end
      end

      return "body {"\
      "  background-image: url('/assets/images/grass/#{shape}_#{range}.png');"\
      "  background-color: #{AnimalCrossing.class_variable_get(:@@GRASS_COLORS)[:"#{range}"]};"\
      "} "\
      ".page-content {"\
      "  background-image: url('/assets/images/sand/#{shape}_#{range}.png');"
      "}"
    end
  end
end

Liquid::Template.register_tag('grass_color', Jekyll::GrassColorTag)