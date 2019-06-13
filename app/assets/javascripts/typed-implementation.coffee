ready = ->
  typed = new Typed('.element',
    strings: [
      'Welcome to the danger zone.'
      'Enjoy your stay..'
    ]
    typeSpeed: 50)
  return

$(document).ready
$(document).on 'turbolinks:load', ready
