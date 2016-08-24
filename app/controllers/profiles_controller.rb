class ProfilesController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index
    @users = User.order("#{sort_column} #{sort_direction}")
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @user = current_user
    if !@user.profile.nil?
      redirect_to root_path
    end
  end

  def create
    @profile = Profile.new(params.require(:profile).permit(:avatar, :first_name, :last_name, :student_class, :bio, :github, :twitter, :website))
    @profile.user = current_user
    authorize! :create, @profile
    @profile.save
    redirect_to @profile
  end

  private

  def sortable_columns
    ["email", "role", "created_at"]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "email"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
