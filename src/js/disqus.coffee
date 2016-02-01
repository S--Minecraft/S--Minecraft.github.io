###
disqus_config = ->
  this.page.url = PAGE_URL
  this.page.identifier = PAGE_IDENTIFIER;
  return
###
d = document
s = d.createElement("script")
s.src = "//s4naxyz.disqus.com/embed.js"
s.setAttribute("data-timestamp", Date.now())
(d.head ? d.body).appendChild(s)
