works = [
  {
    name: "MinecraftModLangFiles"
    desc: "MinecraftのMODのアイテム・ブロックなどを翻訳するlangファイル群です。"
    dl: "http://forum.minecraftuser.jp/viewtopic.php?f=13&t=16447"
    github: "https://github.com/S--Minecraft/MinecraftModLangFiles"
    tags: ["Minecraft", "Other"]
  }
  {
    name: "Sxtra"
    desc: "EnderIO用のConfigです。IndustrialCraft2とそのアドオンのGregtechとArsMagica2とThaumCraft用の準自生粉砕機レシピと合金精錬機レシピを追加します。"
    dl: "http://forum.minecraftuser.jp/viewtopic.php?f=13&t=18070"
    tags: ["Minecraft", "Other"]
  }
  {
    name: "FontGenResourcePack"
    desc: "これは<a href=\"http://mcc.mcsv.jp/FontGen\">FontGen</a>で出力したファイルをリソースパック化するものです。 "
    dl: "http://forum.minecraftuser.jp/viewtopic.php?t=16447&p=156976#p156976"
    tags: ["Minecraft", "Other"]
  }
  {
    name: "Twgitter"
    desc: "<a href=\"https://twitter.com/\">Twitter</a>, <a href=\"https://app.net/\">App.net</a>, <a href=\"https://croudia.com/\">Croudia</a>, <a href=\"https://gitter.im/\">gitter</a>, <a href=\"http://ja.wikipedia.org/wiki/Internet_Relay_Chat\">IRC</a>, <a href=\"https://slack.com/\">Slack</a>用のJava製クライアントです。現在は開発停止していて、Twgitter2の方を開発しています。"
    github: "https://github.com/S--Minecraft/twgitter"
    tags: ["Java"]
  }
  {
    name: "Twgitter2"
    desc: "<a href=\"https://twitter.com/\">Twitter</a>, <a href=\"https://app.net/\">App.net</a>, <a href=\"https://croudia.com/\">Croudia</a>, <a href=\"https://gitter.im/\">gitter</a>, <a href=\"http://ja.wikipedia.org/wiki/Internet_Relay_Chat\">IRC</a>, <a href=\"https://slack.com/\">Slack</a>用のJava/node.js製クライアントです。"
    github: "https://github.com/S--Minecraft/Twgitter2"
    tags: ["Java", "Coffeescript", "Haml", "SCSS", "nodejs", "electron"]
  }
  {
    name: "read.crx 2"
    desc: "Chromeアプリの2chブラウザです。awefさんによって造られ、eruさんに引き継がれました。自分はメンテナーです。"
    dl: "http://readcrx-2.github.io/read.crx-2/"
    github: "https://github.com/readcrx-2/read.crx-2"
    tags: ["Chrome", "Coffeescript", "Haml", "SCSS"]
  }
  {
    name: "MinecraftSourceRecipeImageMaker"
    desc: "jsonからレシピの画像を生成します"
    github: "https://github.com/S--Minecraft/MinecraftSourceRecipeImageMaker"
    tags: ["Go", "Minecraft"]
  }
  {
    name: "MinecraftModLangFilesPacker"
    desc: "MinecraftのMod用langファイルをパックします"
    github: "https://github.com/S--Minecraft/MinecraftModLangFilesPacker"
    tags: ["Coffeescript", "Minecraft", "nodejs"]
  }
  {
    name: "Shooting!"
    desc: "phina.jsを利用したシューティングゲームです"
    dl: "http://s--minecraft.github.io/shooting"
    github: "https://github.com/S--Minecraft/shooting"
    tags: ["Coffeescript", "Haml", "SCSS", "phinajs"]
  }
]

# arr1とarr2を重複なしでconcatする
noDuplicateConcat = (arr1, arr2) ->
  for n in arr2
    flag = true
    for m in arr1
      if n is m
        flag = false
        break
    if flag then arr1.push(n)
  return arr1

makeAllTag = ->
  allTag = []
  for w in works
    allTag = noDuplicateConcat(allTag, w.tags)
  allTag.some( (v, i) ->
    if v is "Other" then allTag.splice(i, 1)
    return
  )
  allTag.sort()
  allTag.unshift("All")
  allTag.push("Other")
  return allTag

setupTabBar = (allTag) ->
  barHtml = ""
  for tag, i in allTag
    if i is 0
      barHtml += "<a href=\"##{tag}\" id=\"#{tag}\" class=\"mdl-tabs__tab is-active\">#{tag}</a>"
    else
      barHtml += "<a href=\"##{tag}\" id=\"#{tag}\" class=\"mdl-tabs__tab\">#{tag}</a>"
  $$.I("works-tab-bar").innerHTML = barHtml
  return

setupTabBarEvent = (allTag) ->
  for tag in allTag
    if tag isnt "All"
      $$.I(tag).on("click", ->
        panels = $$.I("works-panels")
        $$.each(panels.children, (child) ->
          child.addClass("hidden")
          return
        )
        $$.each(panels.C(@id), (dom) ->
          dom.removeClass("hidden")
          return
        )
        return
      )
  $$.I("All").on("click", ->
    $$.each($$.I("works-panels").children, (child) ->
      child.removeClass("hidden")
      return
    )
    return
  )
  return

setupTab = ->
  tabHtml = ""
  for w, i in works
    if w.tags? then tags = w.tags.join(" ") else tags = ""
    t = tags + " work mdl-cell mdl-cell--4-col mdl-card mdl-shadow--3dp"
    tabHtml += "<div class=\"#{t}\">"
    tabHtml += "<h2 class=\"h4\">#{w.name}</h2>"
    tabHtml += "<p>#{w.desc}</p>"
    tabHtml += "<div id=\"buttons\">"
    if w.dl? then tabHtml += "<a href=\"#{w.dl}\"><button class=\"mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect\">Download Page</button></a>"
    if w.github? then tabHtml += "<a href=\"#{w.github}\"><button class=\"mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect\">GitHub</button></a>"
    tabHtml += "</div>"
    if w.tags?
      tabHtml += "<ul>"
      for t in w.tags
        tabHtml += "<li class=\"mdl-shadow--2dp\">#{t}</li>"
      tabHtml += "</ul>"
    tabHtml += "</div>"
  $$.I("works-panels").innerHTML = tabHtml
  return

document.on("DOMContentLoaded", ->
  allTag = makeAllTag()
  setupTabBar(allTag)
  setupTab()
  setupTabBarEvent(allTag)
  componentHandler.upgradeDom()
  return
)
