---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

this site is heavily under construction, so what you see is what you get!

## currently reading

{% for book in site.data.books.currently_reading %}
  - *{{ book.title }}* by {{ book.author }}
{% endfor %}

## find me elsewhere
- 🎮 [backloggd](https://www.backloggd.com/u/loam)
- 📚 [bookwyrm](https://www.bookwyrm.social/user/loam)
- 💻 [github](https://www.github.com/clairefreehafer)
- 🎥 [letterboxxd](https://www.letterboxxd.com/clairefreehafer)
