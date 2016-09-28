class MentorsController < ApplicationController

  def index
    @mentors = Mentor.all
  end

  def new
    @mentor = Mentor.new
  end

  def create
    @mentor = Mentor.new(mentor_params)
    @mentor.save
    redirect_to mentors_path
  end

  private

  def mentor_params
    params.require(:mentor).permit(:name, :start_time, :end_time,
                                    :availability, :calendly_url,
                                    :avatar, :competencies)
  end
end
