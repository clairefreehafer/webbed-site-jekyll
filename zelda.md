---
title: zelda
layout: zelda
---

<img src="/assets/images/zelda/pad-line-1.png" class="splitter" alt="" />

## tears of the kingdom
{% for page in site.zelda -%}
  {%- if page.path contains "tears_of_the_kingdom" %}
- [{{ page.title | escape }}]({{- page.url | relative_url }})
  {%- endif -%}
{%- endfor %}

<img src="/assets/images/zelda/pad-line-2.png" class="splitter" alt="" />

## breath of the wild
{% for page in site.zelda -%}
  {%- if page.path contains "breath_of_the_wild" %}
- [{{ page.title | escape }}]({{ page.url | relative_url }})
  {%- endif -%}
{% endfor %}

<img src="/assets/images/zelda/pad-line-3.png" class="splitter" alt="" />
