class ProfilesController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index
    authorize! :read, @users

    if params[:search]
      profiles = Profile.search(params[:search]).order(created_at: :desc)

      if profiles.any?
        users = []
        profiles.each do |profile|
          user = profile.user
          users << user
        end
        @users = User.where(id: users.map(&:id)).paginate(:page =>params[:page], :per_page => 5)
      end
    else
      @users = User.order("#{sort_column} #{sort_direction}").filter(params.slice(:role, :approved)).paginate(:page =>params[:page], :per_page => 5)
    end

  end

  def show
    @profile = Profile.find(params[:id])
  end

  def approve_user
    user = User.find(params[:id])
    user.approved = true
    user.save
    redirect_to user_management_path
  end

  def disable_user
    user = User.find(params[:id])
    user.disabled = true
    user.save
    redirect_to user_management_path
  end

  def new
    @profile = Profile.new
    @user = current_user
    redirect_to root_path if !@user.profile.nil?
  end

  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    authorize! :create, @profile
    @profile.save
    redirect_to @profile
  end

  def edit
    @profile = Profile.find(params[:id])
    @profile.notification_setting ||= @profile.notification_setting.build
    @user = @profile.user
    authorize! :edit, @profile, @notification
  end

  def update
    @profile = Profile.find(params[:id])

    if @profile.update_attributes(profile_params)
      authorize! :update, @profile
      redirect_to @profile
    else
      render 'edit'
    end
  end

  def edit_role
      user = User.find(params[:id])
      user.role = params[:role]
      user.save
      redirect_to profiles_path
  end

  private

  def sortable_columns
    ["email", "role", "created_at"]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def profile_params
    params.require(:profile).permit(:avatar, :first_name, :last_name, :course_id, :bio, :github, :twitter, :website, notification_setting_attributes: [:send_emails]).tap do |person_params|
      person_params.require([:first_name, :last_name])
    end
  end
end
