---
title: animal crossing
layout: animal_crossing
theme: animal_crossing
---

{%- assign sorted_pages = site.animal_crossing | sort: "date" -%}

## new horizons
{% for page in sorted_pages -%}
  {%- if page.path contains "new_horizons" %}
    {%- capture icon -%}
      {%- if page.icon -%}
        {{ page.icon }}
      {%- else -%}
        star_fragment_{%- star_fragment page.date -%}
      {%- endif -%}
    {%- endcapture %}
- <img src="/assets/images/page_icons/animal_crossing/{{ icon }}.png" class="page-icon" alt=""> [{{ page.title | escape }}]({{- page.url | relative_url }})
  {%- endif -%}
{%- endfor %}

## new leaf
{% for page in sorted_pages -%}
  {%- if page.path contains "new_leaf" %}
- [{{ page.title | escape }}]({{ page.url | relative_url }})
  {%- endif -%}
{% endfor %}