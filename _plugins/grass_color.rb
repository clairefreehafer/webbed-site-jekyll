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
        "#{shape}_1210-0224.png"
      when 2
        if day <= 24 then
          "#{shape}_1210-0224.png"
        else
          "#{shape}_0225-0331.png"
        end
      when 3
        "#{shape}_0225-0331.png"
      when 4..6
        "#{shape}_0401-0722.png"
      when 7
        if day <= 22
          "#{shape}_0401-0722.png"
        else
          "#{shape}_0723-0915.png"
        end
      when 8
        "#{shape}_0723-0915.png"
      when 9
        if day <= 15
          "#{shape}_0723-0915.png"
        else
          "#{shape}_0916-0930.png"
        end
      when 10
        if day <= 15
          "#{shape}_1001-1015.png"
        elsif day <= 29
          "#{shape}_1016-1029.png"
        else
          "#{shape}_1030-1112.png"
        end
      when 11
        if day <= 12
          "#{shape}_1030-1112.png"
        elsif day <= 28
          "#{shape}_1113-1128.png"
        else
          "#{shape}_1129-1209.png"
        end
      when 12
        if day <= 9
          "#{shape}_1129-1209.png"
        else
          "#{shape}_1210-0224.png"
        end
      end

    end
  end
end

Liquid::Template.register_tag('grass_color', Jekyll::GrassColorTag)