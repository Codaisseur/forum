class AnswersController < ApplicationController

  def index
    @answers = Answer.order(created_at: :desc)
  end

  def new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answer.create(params[:answer])
    @answer.user = current_user
    if @answer.save
      flash[:notice] = "Thank you for your answer."
      redirect_to "/questions/#{@answer.question_id}"
    else
      render :action => 'new'
    end
  end

  def update
  end

end
