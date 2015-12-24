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

# twitter
###
twitter = {
  RSSUrl: "https://script.google.com/macros/s/AKfycbyw54VdTAFiXTKf5Rp-QICRaY6w5qP-VjMg0O_ZMWpSUNLbdbc/exec?679237762432675841"
  number: 10
  id: "twitter-timeline"
}

xmlLoad = (url, n, id) ->
  DD = new Date()
  rssUrl = "#{url}?#{DD.getHours()}#{DD.getMinutes()}#{DD.getSeconds()}"
  $.ajax({
    url: rssUrl
    type: "get"
    dataType: "xml"
    timeout: 5000,
    error: ->
      m = "error"
      xmlOpen(m, id, n)
      return
    success: (xml) ->
      twitter.xml = xml
      m = "load"
      xmlOpen(m, id, n)
      return
  })
  return

xmlOpen = (message, id, n) ->
  html = "<ul>"
  if message = "load"
    $(twitter.xml).find("channel > item").each( (i) ->
      $i = $(@)
      if i < n
        d = $i.find("pubDate").text().match(/(\b+)-0?(\b+)-0?(\b+)T0?(\b+):0?(\b+):0?(\b+)+0000/)
        date = new Date(d[1], d[2], d[3], d[4], d[5], d[6])
        link = $i.find("link").text()
        desc = $i.find("description").text().slice(9, -3)
        html += "<li><a href=\"#{link}\">#{desc} #{date}</a></li>"
      return
    )
  else
    html += "<li>通信エラー</li>"
  html += "</ul>"
  $("##{id}").html(html)
  return
###

$ ->
  # Progress Bars
  for key of pLang
    if pLang[key].buffer?
      $("#" + key).on("mdl-componentupgraded", ->
        @MaterialProgress.setProgress(pLang[@.id].v)
        @MaterialProgress.setBuffer(pLang[@.id].buffer)
        return
      )
    else
      $("#" + key).on("mdl-componentupgraded", ->
        @MaterialProgress.setProgress(pLang[@.id].v)
        return
      )

  # Twitter Card
  ###
  xmlLoad(twitter.RSSUrl, twitter.number, twitter.id)
  ###
  twitterWidgetFix = ->
    widget = $("#twitter-widget-0")
    if widget.length > 0
      widget.contents().find("head").append("<style type=\"text/css\">.root{max-width: 100% !important;width: 100% !important;box-sizing: border-box;}</style>")
    else
      setTimeout(twitterWidgetFix, 1500)
  twitterWidgetFix()
  return
