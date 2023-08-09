---
title: animal crossing
layout: animal_crossing
theme: animal_crossing
---

<!-- TODO: sort lists -->

## new horizons
{% for page in site.animal_crossing -%}
  {%- if page.path contains "new_horizons" %}
    {%- capture icon -%}
      {%- if page.icon -%}
        {{ page.icon }}
      {%- else -%}
        star_fragment_{%- star_fragment page.date -%}
      {%- endif -%}
    {%- endcapture %}
- <img src="/assets/images/page_icons/animal_crossing/{{ icon }}.png" class="page-icon"> [{{ page.title | escape }}]({{- page.url | relative_url }})
  {%- endif -%}
{%- endfor %}

## new leaf
{% for page in site.animal_crossing -%}
  {%- if page.path contains "new_leaf" %}
- [{{ page.title | escape }}]({{ page.url | relative_url }})
  {%- endif -%}
{% endfor %}