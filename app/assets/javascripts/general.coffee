$(document).ready ->

  #
  # Scroll to hash link on page
  # Example link: /about#header-2, will scroll to the header with this id
  #
  $("html, body").hide()
  if window.location.hash.length > 0
    setTimeout (->
      $("html, body").scrollTop(0).show()
      $("html, body").animate { scrollTop: $(window.location.hash).offset().top }, 2000
      return
    ), 0
  else
    $("html, body").show()


  #
  # Devbridge Autocomplete
  # @reference: https://github.com/devbridge/jQuery-Autocomplete
  #

  source = $('.jsGlobalSearchAutocomplete').data("source")
  noSuggestionNotice = $(".jsGlobalSearchAutocomplete").data("no-suggestion-notice")
  $(".jsGlobalSearchAutocomplete").devbridgeAutocomplete
    paramName: "q"
    serviceUrl: source
    minChars: 2
    lookupLimit: 10
    showNoSuggestionNotice: true
    noSuggestionNotice: noSuggestionNotice
    triggerSelectOnValidInput: false

    onSelect: (suggestion) ->
      this.closest("form").submit()
      return

  source = $('.jsAjaxAutocomplete').data("source")
  noSuggestionNotice = $(".jsAjaxAutocomplete").data("no-suggestion-notice")
  $(".jsAjaxAutocomplete").devbridgeAutocomplete
    paramName: "q"
    serviceUrl: source
    minChars: 2
    lookupLimit: 10
    # showNoSuggestionNotice: true
    # noSuggestionNotice: noSuggestionNotice
    triggerSelectOnValidInput: false


  #
  # Materialize CSS
  #

  $(".jsButtonCollapse").sideNav()
  $("select").material_select();
  $(".jsParallax").parallax()
  $(".datepicker").pickadate(selectMonths: true, selectYears: 20)

  #
  # JS Timezone Detect
  #

  $.cookie("timezone", jstz.determine().name(), path: "/")
