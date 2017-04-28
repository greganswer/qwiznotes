$(document).ready ->

  #
  # Devbridge Autocomplete
  # @reference: https://github.com/devbridge/jQuery-Autocomplete
  #

  source = $('.jsAjaxAutocomplete').data("source")
  noSuggestionNotice = $(".jsAjaxAutocomplete").data("no-suggestion-notice")

  $(".jsAjaxAutocomplete").devbridgeAutocomplete
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
  $('.dropdown-button').dropdown({ constrainWidth: false, hover: true,alignment: 'right' })

  #
  # JS Timezone Detect
  #

  $.cookie("timezone", jstz.determine().name(), path: "/")
