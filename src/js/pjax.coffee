class @Pjax
  @setting: {}
  @setup: (set) ->
    Pjax.setting.target = set.target ? $$.T("a")
    Pjax.setting.replace = set.replace ? ["title", "icon", "content"]

    document.on("DOMContentLoaded", =>
      $$.each(Pjax.setting.target, (dom) =>
        if history.pushState? and !dom.hasClass("out")
          dom.on("click", @clickPjax, false)
         return
       )
      return
    , false)
    return
  @get: (url, cb) ->
    xhr = new XMLHttpRequest()
    xhr.on("load", ->
      # 成功
      if xhr.status is 0 or 200<=xhr.status<400
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
  @clickPjax: (e) ->
    e.preventDefault()
    console.log "pjax!!!"
    Pjax.get(e.target.href+"/index.html", (html) ->
      parser = new DOMParser()
      doms = parser.parseFromString(html, "text/html")
      oldEle = []
      newEle = []
      for d in Pjax.setting.replace
        oldEle.push($$.I(d))
        newEle.push(doms.I(d))
      # 新しいのを追加
      for _____, i in oldEle
        oldEle[i].addAfter(newEle[i])
      # 古いのを削除
      for _____, i in oldEle
        oldEle[i].remove()
      return
    )
    # urlを変更
    url = e.target.href
    history.pushState(history.state, document.title, url)
    componentHandler.upgradeDom()
    return
