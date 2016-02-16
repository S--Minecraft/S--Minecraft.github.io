pLang = {
  Coffee: { v: 85, buffer: 90 }
  Javascript: { v: 60, buffer: 75 }
  Go: { v: 40, buffer: 75 }
  Java: { v: 20 }
  Swift: { v: 15, buffer: 40 }
  Typescript: { v: 10 }
  CS: { v: 8, buffer: 30 }
  C: { v: 5 }
  HTML: { v: 70 }
  Haml: { v: 65, buffer: 75 }
  SCSS: { v: 40 }
}

set = (obj) ->
  return ->
    @MaterialProgress.setProgress(obj.v)
    if obj.buffer? then @MaterialProgress.setBuffer(obj.buffer)
    return

# Progress Bars
for key, v of pLang
  $$.I(key).on("mdl-componentupgraded", set(v))

document.on("mdl-componentupgraded", ->
  #twitter
  `!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");`
  return
)
