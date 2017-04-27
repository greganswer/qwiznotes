# Comments
#
$ ->
  comments =
    editButton: $(".jsCommentEditButton")
    cancelButton: $(".jsCommentEditCancelButton")

    initialize: ->
      self = this
      @editButton.on "click", -> self.toggleEditingArea($(this))
      @cancelButton.on "click", -> self.toggleEditingArea($(this))

    toggleEditingArea: (button) ->
      button.closest(".comment").find(".jsCommentContent, .jsCommentButtons").toggleClass("hide")
      button.closest(".comment").find(".jsCommentEditForm").toggleClass("hide")

  #
  # Main
  #

  comments.initialize()
