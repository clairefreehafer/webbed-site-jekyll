---
title: animal crossing
layout: animal_crossing
theme: animal_crossing
---

<!-- TODO: make different list pages for each game -->

{%- assign pages_by_game = site.animal_crossing | group_by: "game" | sort: "name" -%}
{%- assign games = "new_horizons" -%}

{% for game in games -%}
## {{ game | replace: "_", " " }}

  {%- assign current_game_pages = pages_by_game | where: "name", game | sort: "name" -%}
  {%- assign pages_by_category = current_game_pages[0].items | group_by: "category" -%}

  {%- for category in pages_by_category -%}
    {%- if category.name.size > 0 %}
    
### {{ category.name }}
    {%- endif -%}

    {%- for page in category.items %}
      {%- capture icon -%}
        {%- if page.icon -%}
          {{ page.icon }}
        {%- else -%}
          star_fragment_{%- star_fragment page.date -%}
        {%- endif -%}
      {%- endcapture %}
- <img src="/assets/images/page_icons/animal_crossing/{{ icon }}.png" class="page-icon" alt=""> [{{ page.title | escape }}]({{- page.url | relative_url }})
    {%- endfor -%}
  {% endfor %}
{%- endfor %} 
