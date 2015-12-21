fixContainer = ->
  container = $("#top-page-container")
  container.height($(window).height()-$("header").outerHeight()-$("footer").outerHeight())
  return

$ ->
  fixContainer()
  return

timer = false
$(window).resize(->
  if timer
    clearTimeout(timer)
  timer = setTimeout(->
    fixContainer()
    return
  , 200)
  return
)
