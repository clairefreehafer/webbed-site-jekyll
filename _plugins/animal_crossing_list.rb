require_relative "utils"

module Jekyll
  class RenderLinksTag < Liquid::Tag
    ANIMAL_CROSSING_GAMES = ["new_horizons"]
    ICON_PATH_PREFIX = "/assets/images/page_icons/animal_crossing/"

    def render_animal_crossing_links(context, pages, current_output)
      output = current_output
      url = context["site"]["url"]

      for page in pages do
        slug = page.slug
        icon_asset = context["site"]["static_files"].find { |file| file.basename == slug }
        
        if page["icon"] then
          icon = url + ICON_PATH_PREFIX + page["icon"] + ".png"
        elsif icon_asset then
          icon = url + icon_asset.url
        else
          icon = url + ICON_PATH_PREFIX + "star_fragment_" + Jekyll.get_star_fragment(page["date"]) + ".png"
        end

        output += "<li><img src='#{icon}' class='page-icon' alt=''> <a href='#{url}#{page.url}'>#{page.title}</a>"
      end

      output += "</ol>"
      output
    end

    def render(context)
      section = context["page"]["name"].split(".")[0]
      pages = context["site"][section]
      url = context["site"]["url"]
      output = ""

      if section == "animal_crossing" then
        pages_by_game = pages.group_by { |page| page["game"] }

        for game in ANIMAL_CROSSING_GAMES do
          output += "<h2>#{game.gsub("_", " ")}</h2>"
          
          pages_by_category = pages_by_game[game].group_by { |page| page["category"] }

          # first: pages with no category
          sorted_pages_with_no_category = pages_by_category[nil].sort_by { |page| page["date"] }
          output += "<ol>"

          output = render_animal_crossing_links(context, sorted_pages_with_no_category, output)

          # next: the rest of the pages with categories
          for category in pages_by_category.keys do
            if category then
              output += "<h3>#{category}</h3><ol>"

              output = render_animal_crossing_links(context, pages_by_category[category], output)
              output += "</ol>"
            end
          end
        end
      end

      output
    end
  end
end

Liquid::Template.register_tag("render_links", Jekyll::RenderLinksTag)
