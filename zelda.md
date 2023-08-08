---
title: zelda
layout: zelda
---

## tears of the kingdom
{% for page in site.zelda -%}
  {%- if page.path contains "tears_of_the_kingdom" %}
- [{{ page.title | escape }}]({{- page.url | relative_url }})
  {%- endif -%}
{%- endfor %}

## breath of the wild
{% for page in site.zelda -%}
  {%- if page.path contains "breath_of_the_wild" %}
- [{{ page.title | escape }}]({{ page.url | relative_url }})
  {%- endif -%}
{% endfor %}