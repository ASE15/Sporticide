class LogsController < ApplicationController

  before_action :authenticate_user!
  before_filter :is_member_of_training!, :only => [:new, :create, :update, :edit, :destroy]
  before_filter :owns_log!, :only => [:update, :edit, :destroy]

  def index
    @session = TrainingSession.find(params[:trainingsession_id])
    @logs = @session.logs
  end

  def new
    @session = TrainingSession.find(params[:trainingsession_id])
    if @session.user_already_logged?(current_user)
      redirect_to @session.training, :alert => 'You have already created a log for this session.'
    else
      @training = @session.training
      @log = @session.logs.build
    end
  end

  def create
    @session = TrainingSession.find(params[:trainingsession_id])

    if @session.user_already_logged?(current_user)
      redirect_to @session.training, :alert => 'You have already created a log for this session.'
    else
      @log = @session.logs.create(log_params)
      @log.user = current_user
      if @log.save
        redirect_to @session.training, :notice => 'Log created.'
      else
        render 'new'
      end
    end
  end

  def edit
    @log = Log.find(params[:id])
    @session = @log.training_session
  end

  def update

  end

  def destroy
    @log = Log.find(params[:id])
    @training = @log.training_session.training
    @log.destroy
    redirect_to @training, :notice => 'You have deleted your log.'
  end

  private
  def log_params
    params.require(:log).permit(:intensity, :rating, :comment)
  end
end
