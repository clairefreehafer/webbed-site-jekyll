---
title: animal crossing
layout: animal_crossing
theme: animal_crossing
---

<!-- TODO: sort lists -->

## new horizons
{% for page in site.animal_crossing -%}
  {%- if page.path contains "new_horizons" %}
- [{{ page.title | escape }}]({{- page.url | relative_url }})
  {%- endif -%}
{%- endfor %}

## new leaf
{% for page in site.animal_crossing -%}
  {%- if page.path contains "new_leaf" %}
- [{{ page.title | escape }}]({{ page.url | relative_url }})
  {%- endif -%}
{% endfor %}