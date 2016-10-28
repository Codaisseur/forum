class CoursesController < ApplicationController
  load_and_authorize_resource

  def index
    @courses = Course.order(:starting_at)

  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.save
    redirect_to courses_path
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])

    if @course.update_attributes(course_params)
      redirect_to courses_path
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    authorize! :destroy, @course
    @course.destroy
    flash.notice = "'#{@course.name}' Deleted!"
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :starting_at, :ending_at)
  end
end
