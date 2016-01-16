gas = "https://script.google.com/macros/s/AKfycbzLI3UBsmd-3OS9_LmiM6DQVXFTP2axRtVwGlinr5ctHBj_NS4/exec?sn="

document.on("DOMContentLoaded", ->
  $$.each($$.C("twiiconImg"), (DOM) ->
    sn = DOM.getAttr("sn")
    xhr = new XMLHttpRequest()
    xhr.open("GET", gas+sn)
    if xhr.timeout?
      xhr.on("timeout", (e) ->
        console.error "XHR Timeout: Twitter Icon getting"
        return
      )
      xhr.timeout = 5000
    xhr.on("load", (e) ->
      img = $__("img")
      img.src = xhr.response
      DOM.addAfter(img)
      DOM.remove()
      return
    )
    xhr.send()
    return
  )
  return
)
