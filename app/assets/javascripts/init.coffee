#for turbolink it should be
#$(document).on 'turbolinks:load', ->
#  console.log 'It works on each visit!'
#  return


$(document).ready ->
  #initialize component

  #$(".sidenav").sidenav()
  #$('.dropdown-button').dropdown()
  #$('.modal').modal()
  #$('select').material_select()
  $('select').formSelect()
  $('.datepicker').datepicker( {
    i18n: {
      months: [ 'มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน', 'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม' ],
      monthsShort: [ 'ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.', 'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.' ],
      weekdays: [ 'อาทิตย์', 'จันทร์', 'อังคาร', 'พุธ', 'พฤหัสบดี', 'ศุกร์', 'เสาร์' ],
      weekdaysShort: [ 'อา.', 'จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.' ],
      weekdaysAbbrev: [ 'อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส' ],
      today: 'วันนี้',
      clear: 'ลบ',
      done: 'ตกลง',
      cancel: 'ยกเลิก'
    }
    format: 'dd-mm-yyyy'
    formatSubmit: 'yyyy/mm/dd'

  }); # initialize any datepicker
  Waves.displayEffect()

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

  console.log "load init on ready or turbolinks:load"
  return
