# Application Welcome Coffee
$(document).on "turbolinks:load", ->
  # Hide Flash Message After 5 Seconds
  # window.setTimeout (->
  #   $('.flash-messages').fadeTo(500, 0).slideUp 500, ->
  #     $(this).hide()
  # ), 5000

  $("li.navbar-profile-icon a.dropdown-toggle").click (e) ->
    return false

  $("li.navbar-profile-icon").hover (->
    $(this).toggleClass 'open'
    return
  ), ->
    $(this).toggleClass 'open'
    return
