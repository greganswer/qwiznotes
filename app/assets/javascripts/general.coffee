$(document).ready ->

  #
  # Devbridge Autocomplete
  # @reference: https://github.com/devbridge/jQuery-Autocomplete
  #

  source = $(".jsGlobalSearchAutocomplete").data("source")
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

  #
  # Materialize CSS
  #

  $(".jsButtonCollapse").sideNav()
  $("select").material_select();
  $(".jsParallax").parallax()
  $(".datepicker").pickadate(selectMonths: true, selectYears: 20)
  $(".dropdown-button").dropdown({ constrainWidth: false, alignment: "right" })
  $("nav .dropdown-button").dropdown({ constrainWidth: false, alignment: "right", hover: true })

  #
  # JS Timezone Detect
  #

  $.cookie("timezone", jstz.determine().name(), path: "/")
