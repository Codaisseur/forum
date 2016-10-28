class SlackConfigsController < ApplicationController

  def show
    @slack_config = SlackConfig.first
  end

  def index
    @slack_config = SlackConfig.first
  end

  def new
    @slack_config = SlackConfig.new
  end

  def edit
    @slack_config = SlackConfig.first
  end

  def create
    @slack_config = SlackConfig.new(slack_params)
    authorize! :create, @slack_config
    if @slack_config.save()
      redirect_to slack_configs_path
    else
      render :new
    end
  end

  def update
    @slack_config = SlackConfig.first

    if @slack_config.update_attributes(slack_params)
      redirect_to slack_configs_path
    else
      render 'edit'
    end
  end

  def slack_params
    params.require(:slack_config).permit(:web_hook, :channel, :user_name)
  end
end
