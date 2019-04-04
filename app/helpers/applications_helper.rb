module ApplicationsHelper
  def progress_bar(app)
    width = 5
    case app.state
    when 'applying'
      width = 10
    when 'registered'
      width = 20
    when 'confirmed'
      width = 40
    when 'submitted'
      width = 60
    when 'evaluated'
      width = 80
    when 'awarded'
      width = 100
    end

    render partial: 'applications/field/progress_bar', locals: {width: width}
  end

  def state_full(app)
    case app.state
    when 'applying'
      text_color = 'light-blue-text'
    when 'registered'
      text_color = 'orange-text'
    when 'confirmed'
      text_color = 'pink-text'
    when 'submitted'
      text_color = 'lime-green-text'
    when 'evaluated'
      text_color = 'brown-text'
    when 'awarded'
      text_color = 'black-text'
    end

    a = render partial: 'applications/field/state', locals: {text_color: text_color, state_text: app.state_text}
    b = progress_bar(app)
    return a+b
  end
end
