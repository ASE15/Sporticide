class TrainingSessionsController < ApplicationController
  before_action :authenticate_user!
  before_filter :owns_training!, :only => [:new, :create, :update, :edit, :destroy]

  def index

  end

  def show
    @training = Training.find(params[:training_id])
    @session = TrainingSession.find(params[:id])
  end

  def new
    @training = Training.find(params[:training_id])
    @session = @training.training_sessions.build
  end

  def create
    @training = Training.find(params[:training_id])
    @session = @training.training_sessions.create(session_params)
    if @training.save
      redirect_to @training
    else
      render 'new'
    end
  end

  def edit
    @training = Training.find(params[:training_id])
    @session = TrainingSession.find(params[:id])
    #ToDo: Check if session belongs to training
  end

  def update
    @training = Training.find(params[:training_id])
    @session = TrainingSession.find(params[:id])

    if @session.update(session_params)
      redirect_to @training
    else
      render 'edit'
    end
  end

  def destroy
    @training = Training.find(params[:training_id])
    @session = Session.find(params[:id])

    @session.destroy

    redirect_to @training
  end

  private
  def session_params
    params.require(:training_session).permit(:datetime, :duration, :level, :length, :location)
  end
end