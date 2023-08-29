---
title: books
layout: default
---

## currently reading
{% for book in site.data.books.currently_reading %}
  - *{{ book.title }}* by {{ book.author }}
    - tags: {{ book.tags | array_to_sentence_string }}
{% endfor %}

## read
{% for book in site.data.books.read %}
  - *{{ book.title }}* by {{ book.author }}
    - tags: {{ book.tags | array_to_sentence_string }}
{% endfor %}
