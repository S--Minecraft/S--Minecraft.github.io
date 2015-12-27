fixContainer = ->
  windowHeight = window.innerHeight
  topbottomHeight = $$.T("header")[0].offsetHeight + $$.T("footer")[0].offsetHeight
  $$.I("top-page-container").style.height = ((windowHeight-topbottomHeight) + "px")
  return

document.on("DOMContentLoaded", fixContainer, false)
s.load = fixContainer

timer = false
window.on("resize", ->
  if timer
    clearTimeout(timer)
  timer = setTimeout(->
    fixContainer()
    return
  , 200)
  return
, false)

console.log "top load"
