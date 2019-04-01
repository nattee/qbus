#for turbolink it should be
#$(document).on 'turbolinks:load', ->
#  console.log 'It works on each visit!'
#  return


$(document).ready ->
  #initialize component

  #$(".sidenav").sidenav()
  #$('.dropdown-button').dropdown()
  #$('select').material_select()
  $('.modal').modal()
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


  window.dataTableDefaultOption = (variable) ->
    {
      'lengthChange': false,
      'language': {
        'lengthMenu': 'แสดง _MENU_ รายการ',
        'zeroRecords': 'ไม่มีรายการที่ตรงกับการค้นหา',
        'info': 'แสดงรายการที่ _START_ ถึง _END_ จากทั้งหมด _TOTAL_ รายการ',
        'infoEmpty': 'แสดงรายการที่ 0 ถึง 0 จากทั้งหมด 0 รายการ',
        'infoFiltered': '(กรองมาจากรายการทั้งหมด _MAX_ รายการ)',
        'search': 'ค้นหา',
        'paginate': {
          "first": 'หน้าแรก',
          "last": 'หน้าสุดท้าย',
          "next": 'ถัดไป',
          "previous": 'ก่อนหน้า'
        }
      }
    }

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

  #$('.dataTable').DataTable()
  #should be called directly in each page because of different options

  console.log "load init on ready or turbolinks:load"
  return
