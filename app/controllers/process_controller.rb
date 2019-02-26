class ProcessController < ApplicationController
  def appointment_index
    @to_be_appointed = Application.to_be_appointed
  end

  def appointment_form
    #respond_to :js
  end

  def appointment_post
  end

  def evaluation_index
  end

  def evaluation
  end

  def evaluation_post
  end

  def award_index
  end

  def award
  end

  def award_post
  end
end
