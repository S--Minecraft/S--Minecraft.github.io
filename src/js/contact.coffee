check = ->
  if not /^(?:https?:\/\/)?s--minecraft\.github\.io\/contact\/?(?:index.html)?$/i.test($$.I("url").value)
    return false
  return true

send = ->
  $form = $$.I("form-main")
  $button = $$.I("submit")
  $status = $$.I("status")
  xhr = new XMLHttpRequest()
  xhr.on("load", ->
    # 成功
    if 200<=xhr.status<400
      $form.reset()
      $status.innerHTML = "<i class=\"material-icons\">done</i>Sent successfully"
      $status.removeClass("error")
      $status.addClass("success")
      $button.rmvAttr("disabled")
    else
      $status.innerHTML = "<i class=\"material-icons\">error</i>Errored requesting"
      $status.removeClass("success")
      $status.addClass("error")
      $button.rmvAttr("disabled")
    return
  , false)
  xhr.on("timeout", ->
    $status.innerHTML = "<i class=\"material-icons\">error</i>Errored requesting has been timeout"
    $status.removeClass("success")
    $status.addClass("error")
    $button.rmvAttr("disabled")
    return
  , false)
  xhr.on("loadstart", ->
    $button.attr("disabled", true)
    return
  , false)
  xhr.open("POST", "https://script.google.com/macros/s/AKfycbw4z8qk2haZYjgaB_W9noCGttOIk7JJiscsCENtQhjG1hN2JfG8/exec")
  xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
  data = "from_email="+$$.I("email").value
  data += "&from_name="+$$.I("name").value
  data += "&subject="+$$.I("title").value
  data += "&message="+$$.I("message").value
  xhr.timeout = 10000
  xhr.send(data)
  return

form = ->
  $$.I("form-main").on("submit", (e) ->
    e.preventDefault()
    # 有効化どうか判定
    if check()
      # 送信
      send()
    else
      $status = $$.I("status")
      $status.innerHTML = "<i class=\"material-icons\">error</i>Errored sending"
      $status.removeClass("success")
      $status.addClass("error")
    return
  , false)
  return

document.on("DOMContentLoaded", ->
  # フォーム
  form()
  return
, false)
