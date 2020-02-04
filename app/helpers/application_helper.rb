module ApplicationHelper

  FLASH_MSG_CLASS = {
    success: 'green lighten-4',
    error: 'red lighten-4',
    alert: 'orange lighten-4',
    notice: 'light-blue lighten-4'
  }

  FLASH_MSG_TEXTCOLOR = {
    success: 'green-text',
    error: 'red-text',
    alert: 'orange-text',
    notice: 'deep-purple-text darken-3',
  }
  def flash_class(flash_type)
    FLASH_MSG_CLASS.fetch(flash_type.to_sym, flash_type.to_s)
  end

  def flash_textcolor(flash_type)
    FLASH_MSG_TEXTCOLOR.fetch(flash_type.to_sym, flash_type.to_s)
  end

  def ldate(dt, hash = {})
    dt ? l(dt, hash) : nil
  end

end
