class LogsController < ApplicationController
  include LogsHelper

  before_action :authenticate_user!
  before_filter :is_member_of_training!, :only => [:new, :create, :update, :edit, :destroy]
  before_filter :owns_log!, :only => [:update, :edit, :destroy]

=begin
  def index
    @session = TrainingSession.find(params[:trainingsession_id])
    @logs = @session.logs
  end
=end

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

      create_cc_entry(session[:user_id], session[:passwd], @session.training.sport, @session, @log)
      id = get_last_cc_entry(session[:user_id], session[:passwd], @session.training.sport)

      @log.cc_entry_id = id

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
    @log = Log.find(params[:id])
    tsession = @log.training_session
    training = @log.training_session.training
    sport = training.sport

    if @log.update(log_params)
      update_cc_entry(session[:user_id], session[:passwd], sport, tsession, @log)
      redirect_to training
    else
      render 'edit'
    end
  end

  def destroy
    @log = Log.find(params[:id])
    @training = @log.training_session.training
    delete_cc_entry(session[:user_id], session[:passwd], @training.sport, @log.cc_entry_id)
    @log.destroy
    redirect_to @training, :notice => 'You have deleted your log.'
  end

  private
  def log_params
    params.require(:log).permit(:intensity, :rating, :comment)
  end
end
