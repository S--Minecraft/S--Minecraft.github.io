check = ->
  $form = $("#form-main")
  if not /^(?:https?:\/\/)?s--minecraft\.github\.io\/contact\/?(?:index.html)?$/i.test($form.find("#url").val())
    return false
  return true

send = ->
  $form = $("#form-main")
  $button = $form.find("#submit")
  $status = $("#form").find("#status")
  $.ajax({
    type: "POST"
    url: "https://script.google.com/macros/s/AKfycbw4z8qk2haZYjgaB_W9noCGttOIk7JJiscsCENtQhjG1hN2JfG8/exec"
    data: {
      "from_email": $form.find("#email").val()
      "from_name": $form.find("#name").val()
      "subject": $form.find("#title").val()
      "message": $form.find("#message").val()
    }
    timeout: 10000
    beforeSend: ->
      $button.attr("disabled", true)
      return
  }).done( (res) ->
    $form[0].reset()
    $status.html("<i class=\"material-icons\">done</i>Sent successfully")
    $status.removeClass("error")
    $status.addClass("success")
    return
  ).fail( (res) ->
    $status.html("<i class=\"material-icons\">error</i>Errored sending")
    $status.removeClass("success")
    $status.addClass("error")
    return
  ).always( (xhr) ->
    $button.attr("disabled", false)
    return
  )
  return

form = ->
  $("#form-main").on("submit", (e) ->
    e.preventDefault()
    # 有効化どうか判定
    if check()
      # 送信
      send()
    else
      $status = $("#form").find("#status")
      $status.html("<i class=\"material-icons\">error</i>Errored sending")
      $status.removeClass("success")
      $status.addClass("error")
    return
  )
  return

$ ->
  # フォーム
  form()
  return
