api = "https://api.4na.xyz/twitter/user/show/icon/"
params = "?size=large&type=https"

insertImg = (DOM, xhr) ->
  return (e) ->
    img = $__("img")
    img.src = xhr.response
    DOM.parentNode.insertBefore(img, DOM.nextSibling)
    DOM.parentNode.removeChild(DOM)
    return

document.on("DOMContentLoaded", ->
  for DOM in $$.C("twiiconImg")
    sn = DOM.getAttr("sn")
    xhr = new XMLHttpRequest()
    xhr.open("GET", api+sn+params)
    if xhr.timeout?
      xhr.on("timeout", (e) ->
        console.error "XHR Timeout: Twitter Icon getting"
        return
      )
      xhr.timeout = 5000
    xhr.on("load", insertImg(DOM, xhr))
    xhr.send()
  return
)
