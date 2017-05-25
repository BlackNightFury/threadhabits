$ ->
  $("#toggle-filter-menu-desktop").click ->
    $("#filter-panel").toggle()

  $("#navbar-search-xs").click (e) ->
    e.preventDefault()
    $("#navbar-search-form-xs").slideToggle()