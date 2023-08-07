module Jekyll
  class GrassColorTag < Liquid::Tag

    def initialize(tag_name, variables, tokens)
      super

      @variables = variables.split(" ")

      @shape = @variables[0]
      @page_date = @variables[1]
    end

    def render(context)
      date = context[@page_date.strip]
      month = date.month
      day = date.day

      case month
      when 1
        "#{@shape}_1210-0224.png"
      when 2
        if day <= 24 then
          "#{@shape}_1210-0224.png"
        else
          "#{@shape}_0225-0331.png"
        end
      when 3
        "#{@shape}_0225-0331.png"
      when 4..6
        "#{@shape}_0401-0722.png"
      when 7
        if day <= 22
          "#{@shape}_0401-0722.png"
        else
          "#{@shape}_0723-0915.png"
        end
      when 8
        "#{@shape}_0723-0915.png"
      when 9
        if day <= 15
          "#{@shape}_0723-0915.png"
        else
          "#{@shape}_0916-0930.png"
        end
      when 10
        if day <= 15
          "#{@shape}_1001-1015.png"
        elsif day <= 29
          "#{@shape}_1016-1029.png"
        else
          "#{@shape}_1030-1112.png"
        end
      when 11
        if day <= 12
          "#{@shape}_1030-1112.png"
        elsif day <= 28
          "#{@shape}_1113-1128.png"
        else
          "#{@shape}_1129-1209.png"
        end
      when 12
        if day <= 9
          "#{@shape}_1129-1209.png"
        else
          "#{@shape}_1210-0224.png"
        end
      end

    end
  end
end

Liquid::Template.register_tag('grass_color', Jekyll::GrassColorTag)