$(document).ready ->
  $(".jsButtonCollapse").sideNav()
  $('select').material_select();
  $('.jsParallax').parallax()

  # Auto resize textarea as input increases
  #
  # reference: http://stackoverflow.com/a/25621277/6615480
  # otherwise try this script: http://www.jacklmoore.com/autosize/
  #
  $('textarea').each(->
    @setAttribute 'style', 'height:' + @scrollHeight + 'px; overflow-y: hidden;'
    return
  ).on 'input', ->
    @style.height = 'auto'
    @style.height = @scrollHeight + 'px'
    return
