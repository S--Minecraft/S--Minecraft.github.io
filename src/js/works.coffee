setupTabBarEvent = ->
  $$.each($$.I("works-tab-bar").children, (dom) ->
    if not (dom.id is "All" or dom.id is "works-panels")
      dom.on("click", ->
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

document.on("DOMContentLoaded", ->
  setupTabBarEvent()
  return
)
