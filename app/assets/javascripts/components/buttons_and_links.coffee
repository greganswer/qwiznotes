$ ->

  #
  # Scroll to link
  #
  $(".jsScrollToLink").on "click", ->
    $("html, body").animate { scrollTop: $(@getAttribute("href")).offset().top }, 500

  #
  # Scroll to hash link on page
  # Example link: /about#header-2, will scroll to the header with this id
  #
  # $("html, body").hide()
  # if window.location.hash.length > 0
  #   setTimeout (->
  #     $("html, body").scrollTop(0).show()
  #     $("html, body").animate { scrollTop: $(window.location.hash).offset().top }, 2000
  #     return
  #   ), 0
  # else
  #   $("html, body").show()


  #----------------------------------------------
  # SCROLL TO TOP
  #----------------------------------------------

  # Fade in/out buttons on scroll

  $(document).on "scroll", ->
    scrollTopButton = $(".jsScrollToTop")
    scrollBottomButton = $(".jsScrollToBottom")
    topDelta = $(window).scrollTop() > $(window).height()
    bottomDelta = $(window).scrollTop() < $(document).height() - ($(window).height() * 2)
    if topDelta then scrollTopButton.fadeIn() else scrollTopButton.fadeOut()
    if bottomDelta then scrollBottomButton.fadeIn() else scrollBottomButton.fadeOut()

  # Scroll to top on click

  $(".jsScrollToTop").click ->
    $("html, body").animate { scrollTop: 0 }, 800

  # Scroll to bottom on click

  $(".jsScrollToBottom").click ->
    $("html, body").animate { scrollTop: $(document).height() - $(window).height() }, 800
