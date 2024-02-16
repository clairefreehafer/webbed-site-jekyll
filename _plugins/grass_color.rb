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

      colors = {
        :"1210-0224" => "rgb(189, 215, 238)",
        :"0225-0331" => "rgb(31, 140, 57)",
        :"0401-0722" => "rgb(0, 131, 90)",
        :"0723-0915" => "rgb(19, 115, 82)",
        :"0916-0930" => "rgb(73, 123, 49)",
        :"1001-1015" => "rgb(132, 123, 58)",
        :"1016-1029" => "rgb(148, 99, 99)",
        :"1030-1112" => "rgb(148, 90, 98)",
        :"1113-1128" => "rgb(132, 90, 82)",
        :"1129-1209" => "rgb(99, 81, 82)",
      }

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
      "  background-color: #{colors[:"#{range}"]};"\
      "} "\
      ".page-content {"\
      "  background-image: url('/assets/images/sand/#{shape}_#{range}.png');"
      "}"
    end
  end
end

Liquid::Template.register_tag('grass_color', Jekyll::GrassColorTag)