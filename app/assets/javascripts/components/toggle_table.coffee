# Toggle between table and tile view
#
$ ->
  toggleTableButton =
    button: $(".jsToggleTable")
    cookieName: "is_index_showing_table"
    tableDiv: $(".jsToggleTable__table")
    tileDiv: $(".jsToggleTable__tile")

    initialize: ->
      self = this
      @switchToTableView(@button) if @isIndexShowingTable()
      @button.on "click", -> self.toggle $(this)

    toggle: (button) ->
      if @isIndexShowingTable()
        @switchToTileView(button)
      else
        @switchToTableView(button)

    isIndexShowingTable:  ->
      $.cookie(@cookieName) == "true"

    switchToTableView: (button) ->
      @button.find("i").removeClass("fa-list").addClass("fa-th")
      @tableDiv.removeClass("hide")
      @tileDiv.addClass("hide")
      $.cookie(@cookieName, "true", path: "/")

    switchToTileView: (button) ->
      @button.find("i").removeClass("fa-th").addClass("fa-list")
      @tableDiv.addClass("hide")
      @tileDiv.removeClass("hide")
      $.cookie(@cookieName, "false", path: "/")

  #
  # Main
  #

  toggleTableButton.initialize()
