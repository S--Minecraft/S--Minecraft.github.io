get = (url, cb) ->
  xhr = new XMLHttpRequest()
  xhr.on("load", ->
    # 成功
    if 200<=xhr.status<400
      cb(xhr.responseText)
      return
    else
      cb(null)
      return
    return
  , false)
  xhr.open("GET", url)
  xhr.send()
  return

pjax = new Pjax({
  elements: "a"
  selectors: ["title", "#menu", "#nav", "#content"]
})

load = ->
  s.load()
  s.load = null
  window.off("load", load, false)
  return

@s = {}
pages = ["profile", "works", "contact"]
document.on("pjax:success", ->
  script = $__("script")
  script.type = "text/javascript"
  m = location.href.match(/s--minecraft\.github\.io\/?(?:(.+)\/?)?(?:index\.html)?/i)
  if not m[1]?
    src = "./js/top.js"
  else
    for page in pages
      if m[1] is page
        src = "../js/#{page}.js"
  if src?
    get(src, (text) ->
      console.log text
      script.innerHTML = text
      Pjax.evalScript(script)
      if s.load?
        window.on("load", load, false)
      return
    )
, false)
