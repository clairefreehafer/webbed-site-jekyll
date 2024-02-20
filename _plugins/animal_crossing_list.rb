module Jekyll
  class AnimalCrossingListBlock < Liquid::Block
    ICON_PATH_PREFIX = "/assets/images/page_icons/animal_crossing/"
    
    def get_star_fragment(date)
      month = date.month
      day = date.day

      astrologyDateRanges = {
        :capricorn => "1222-0119",
        :aquarius => "0120-0218",
        :pisces => "0219-0320",
        :aries => "0321-0419",
        :taurus => "0420-0520",
        :gemini => "0521-0621",
        :cancer => "0622-0722",
        :leo => "0723-0822"
      }

      case month
      when 1
        if day <= 19 then
          astrologyDateRanges[:capricorn]
        else
          astrologyDateRanges[:aquarius]
        end
      when 2
        if day <= 18 then
          astrologyDateRanges[:aquarius]
        else
          astrologyDateRanges[:pisces]
        end
      when 3
        if day <= 20 then
          astrologyDateRanges[:pisces]
        else
          astrologyDateRanges[:aries]
        end
      when 4
        if day <= 19 then
          astrologyDateRanges[:aries]
        else
          astrologyDateRanges[:taurus]
        end
      when 5
        if day <= 20 then
          astrologyDateRanges[:taurus]
        else
          astrologyDateRanges[:gemini]
        end
      when 6
        if day <= 21 then
          astrologyDateRanges[:gemini]
        else
          astrologyDateRanges[:cancer]
        end
      when 7
        if day <= 22 then
          astrologyDateRanges[:cancer]
        else
          astrologyDateRanges[:leo]
        end
      when 8
        if day <= 22 then
          astrologyDateRanges[:leo]
        end
      # when 9
      #   if day <= 15
      #     "#{@shape}_0723-0915.png"
      #   else
      #     "#{@shape}_0916-0930.png"
      #   end
      # when 10
      #   if day <= 15
      #     "#{@shape}_1001-1015.png"
      #   elsif day <= 29
      #     "#{@shape}_1016-1029.png"
      #   else
      #     "#{@shape}_1030-1112.png"
      #   end
      # when 11
      #   if day <= 12
      #     "#{@shape}_1030-1112.png"
      #   elsif day <= 28
      #     "#{@shape}_1113-1128.png"
      #   else
      #     "#{@shape}_1129-1209.png"
      #   end
      # when 12
      #   if day <= 9
      #     "#{@shape}_1129-1209.png"
      #   else
      #     "#{@shape}_1210-0224.png"
      #   end
      end
    end

    def render(context)
      pages_variable = super
      url = context["site"]["url"]
      output = "<ol>"

      pages = context[pages_variable.strip]

      sorted_pages = pages.sort_by { |page| page["date"] }

      for page in sorted_pages do
        slug = page.slug
        icon_asset = context["site"]["static_files"].find { |file| file.basename == slug }
        
        if page["icon"] then
          icon = url + ICON_PATH_PREFIX + page["icon"] + ".png"
        elsif icon_asset then
          puts icon_asset
          icon = url + icon_asset.url
        else
          icon = url + ICON_PATH_PREFIX + "star_fragment_" + get_star_fragment(page.date) + ".png"
        end

        output += "<li>"

        output += "<img src='#{icon}' class='page-icon' alt=''> <a href='#{url}#{page.url}'>#{page.title}</a>"

        output += "</li>"
      end

      output += "</ol>"

      output
    end
  end
end

Liquid::Template.register_tag("animal_crossing_list", Jekyll::AnimalCrossingListBlock)
