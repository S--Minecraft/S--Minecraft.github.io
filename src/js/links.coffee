gas = "https://script.google.com/macros/s/AKfycbzLI3UBsmd-3OS9_LmiM6DQVXFTP2axRtVwGlinr5ctHBj_NS4/exec?sn="

document.addEventListener("DOMContentLoaded", ->
  for DOM in document.getElementsByClassName("twiiconImg")
    sn = DOM.getAttribute("sn")
    xhr = new XMLHttpRequest()
    xhr.open("GET", gas+sn)
    if xhr.timeout?
      xhr.addEventListener("timeout", (e) ->
        console.error "XHR Timeout: Twitter Icon getting"
        return
      )
      xhr.timeout = 5000
    xhr.addEventListener("load", (e) ->
      img = $__("img")
      img.src = xhr.response
      DOM.parentNode.insertBefore(img, DOM.nextSibling)
      DOM.parentNode.removeChild(DOM)
      return
    )
    xhr.send()
    return
  return
)
