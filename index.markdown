---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

## currently reading

{% for book in site.data.books.currently_reading %}
  - {{ book.title }} by {{ book.author }}
{% endfor %}
