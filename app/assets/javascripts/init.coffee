#for turbolink it should be
#$(document).on 'turbolinks:load', ->
#  console.log 'It works on each visit!'
#  return


$(document).ready ->
  $(".sidenav").sidenav()
  $('.dropdown-button').dropdown()
  $('.modal').modal()
  #$('select').material_select()
  $('select').formSelect()
  Waves.displayEffect()
  console.log "load init on ready or turbolinks:load"

  #$('.select2').select2({
  #    theme: "material"
  #})

  #$(".select2-selection__arrow")
  #    .addClass("material-icons")
  #    .html("arrow_drop_down")

  $('textarea').trigger('autoresize')
  $('span.help-text').each ->
    $value = $(this)[0].innerHTML
    $(this).addClass 'hide'
    $(this).parents('div.input-field').children('label').attr(
      'data-hint', $value
    )


  #closing alert
  $('.card-alert .close').click ->
    $(this).closest('.card-alert').fadeOut('slow')

  return
