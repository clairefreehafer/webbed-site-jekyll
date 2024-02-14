---
title: photography
layout: default
---

## photography

{% for page in site.photography -%}
  {% unless page.hide -%}
    - [{{ page.title | escape }}]({{ page.url | relative_url }})
  {% endunless %}
{% endfor %}

for a more extensive (and possibly overwhelming) collection of my photography, check out my [smugmug](https://clairefreehafer.smugmug.com)!