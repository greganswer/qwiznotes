# Toggle between table and tile view
#
$ ->
  toggleTableButton =
    button: $(".jsToggleTable")
    cookieName: "is_index_showing_tiles"
    tableDiv: $(".jsToggleTable__table")
    tileDiv: $(".jsToggleTable__tile")

    initialize: ->
      self = this
      @switchToTileView(@button) if @isIndexShowingTiles()
      @button.on "click", -> self.toggle $(this)

    toggle: (button) ->
      if @isIndexShowingTiles()
        @switchToTableView(button)
      else
        @switchToTileView(button)

    isIndexShowingTiles:  ->
      $.cookie(@cookieName) == "true"

    switchToTableView: (button) ->
      @button.find("i").removeClass("fa-list").addClass("fa-th")
      @tableDiv.removeClass("hide")
      @tileDiv.addClass("hide-on-large-only")
      $.cookie(@cookieName, "false", path: "/")

    switchToTileView: (button) ->
      @button.find("i").removeClass("fa-th").addClass("fa-list")
      @tableDiv.addClass("hide")
      @tileDiv.removeClass("hide-on-large-only")
      $.cookie(@cookieName, "true", path: "/")

  #
  # Main
  #

  toggleTableButton.initialize()
