class ReportController < ApplicationController
  def award
    @apps = Application.won_award
  end
end
