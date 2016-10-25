class NotificationSettingsController < ApplicationController

  def new
    @notification = Notification.find(params[:id])
  end

  def create
    @profile = Profile.find(notification_params[:profile_id])
    @notification = current_user.notification_settings.create(notification_params)
    redirect to profile_path
  end



  Private

  def notification_params
    params.require(:notificaton_setting).permit(:asker_sees_replies, :member_sees_replies, :profile_id, :user_id)
  end
