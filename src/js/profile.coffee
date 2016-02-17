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

setProgress = (obj) ->
  return ->
    @MaterialProgress.setProgress(obj.v)
    if obj.buffer? then @MaterialProgress.setBuffer(obj.buffer)
    return

get = (url, cb) ->
  xhr = new XMLHttpRequest()
  xhr.open("GET", url, true)
  xhr.on("load", ->
    if @status is 200
      cb(@response)
  )
  xhr.send()
  return

escape = (text) ->
  ESCAPE_TABLE = {
    "&": "&amp;"
    "\"": "&quot;"
    "<": "&lt;"
    ">": "&gt;"
  }
  return text.replace(/[&"<>]/g, (match) ->
    return ESCAPE_TABLE[match]
  )

# Progress Bars
for key, v of pLang
  $$.I(key).on("mdl-componentupgraded", setProgress(v))

document.on("mdl-componentupgraded", ->
  #twitter
  `!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");`
  return
)
document.on("DOMContentLoaded", ->
  get("https://api.github.com/users/S--Minecraft", (res) ->
    obj = JSON.parse(res)
    console.log obj
    title = $$.I("github").C("name")[0]
    console.log title
    title.insertAdjacentHTML("beforeend", obj.name)
    title.insertAdjacentHTML("afterend", "<img src=#{obj.avatar_url}>")
    buttons = $$.I("github").C("buttons")[0]
    text = """
           <a href="https://github.com/S--Minecraft/followers"><span class="mdl-badge" data-badge="#{obj.followers}">Followers</span></a>
           <a href="https://github.com/S--Minecraft/following"><span class="mdl-badge" data-badge="#{obj.following}">Following</span></a>
           <a href="https://github.com/S--Minecraft?tab=repositories"><span class="mdl-badge" data-badge="#{obj.public_repos}">Repos</span></a>
           <a href="https://gist.github.com/S--Minecraft"><span class="mdl-badge" data-badge="#{obj.public_gists}">Gists</span></a>
           """
    buttons.insertAdjacentHTML("beforeend", text)
    return
  )
  get("https://api.github.com/users/S--Minecraft/subscriptions", (res) ->
    repos = JSON.parse(res)
    langList = {}
    length = 0
    for r, i in repos
      if r.language?
        if langList[r.language]?
          langList[r.language]++
        else
          langList[r.language] = 1
      #else
      #  if langList.none?
      #    langList.none++
      #  else
      #    langList.none = 1
      length = i
    sorted = Object.keys(langList).sort((a,b) -> return langList[b]-langList[a])

    langs = $$.I("github").T("ol")[0]
    text = ""
    for s in sorted
      percent = Math.round(langList[s]/length*100)
      text += "<li>#{s}: #{percent}% (#{langList[s]})</li>"
    langs.insertAdjacentHTML("beforeend", text)
  )
  return
)
