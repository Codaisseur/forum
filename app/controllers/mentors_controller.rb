class MentorsController < ApplicationController
  load_and_authorize_resource

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

  def edit
  end

  def update
    if @mentor.update_attributes(mentor_params)
      redirect_to mentors_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize! :destroy, @mentor
    @mentor.destroy
    flash.notice = "'#{@mentor.name}' Deleted!"
    redirect_to mentors_path
  end

  private

  def mentor_params
    params.require(:mentor).permit(:name, :start_time, :end_time,
                                    :availability, :calendly_url,
                                    :avatar, :competencies)
  end
end
