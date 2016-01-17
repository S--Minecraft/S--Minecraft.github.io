gas = "https://script.google.com/macros/s/AKfycbzLI3UBsmd-3OS9_LmiM6DQVXFTP2axRtVwGlinr5ctHBj_NS4/exec?sn="

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
    xhr.open("GET", gas+sn)
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
