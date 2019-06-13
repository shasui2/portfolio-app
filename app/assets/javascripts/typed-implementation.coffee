ready = ->
  typed = new Typed('.element',
    strings: [
      'Welcome to the danger zone.'
      'Enjoy your stay..'
    ]
    typeSpeed: 40
    backSpeed: 20
    backDelay: 500
    startDelay: 1000
    loop: false)
  return

$(document).ready
$(document).on 'turbolinks:load', ready
