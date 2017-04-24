$ ->

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
