class TrainingSessionsController < ApplicationController
  before_action :authenticate_user!
  before_filter :owns_training!, :only => [:new, :create, :update, :edit, :destroy]

  def index

  end

=begin
  def show
    @training = Training.find(params[:training_id])
    @session = TrainingSession.find(params[:id])
  end
=end

  def new
    @training = Training.find(params[:training_id])
    @session = @training.training_sessions.build
  end

  def create
    @training = Training.find(params[:training_id])
    @session = @training.training_sessions.create(session_params)

    if @training.save
      @system_log = @session.system_logs.build
      @system_log.training_session_id = @session.id
      @system_log.log = "New training session for " + @training.title + " created!"
      @system_log.save
      @members = @training.users
      @members.each do |m|
        m_user = User.find(m.username)
        TrainingMailer.new_training(@training, @session, m_user).deliver_now
        @training_notifier = @system_log.training_notifiers.build
        @training_notifier.local_user_id = m.id
        @training_notifier.system_log_id = @system_log.id
        @training_notifier.isRead = false
        @training_notifier.save

      end
      redirect_to @training, :notice => "Training session created"
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
      @system_log = @session.system_logs.build
      @system_log.training_session_id = @session.id
      @system_log.log = "A training session for " + @training.title + " updated!"
      @system_log.save
      @members = @training.users
      @members.each do |m|
        m_user = User.find(m.username)
        TrainingMailer.edited_training(@training, @session, m_user).deliver_now
        @training_notifier = @system_log.training_notifiers.build
        @training_notifier.local_user_id = m.id
        @training_notifier.system_log_id = @system_log.id
        @training_notifier.isRead = false
        @training_notifier.save
      end
      redirect_to @training, :notice => "Training session updated"
    else
      render 'edit'
    end
  end

  def destroy
    @training = Training.find(params[:training_id])
    @session = TrainingSession.find(params[:id])
    @session.destroy
    @system_log = @session.system_logs.build
    @system_log.training_session_id = @session.id
    @system_log.log = "A training session for " + @training.title + " deleted!"
    @system_log.save
    @members = @training.users
    @members.each do |m|
      m_user = User.find(m.username)
      TrainingMailer.destroyed_training(@training, @session, m_user).deliver_now
      @training_notifier = @system_log.training_notifiers.build
      @training_notifier.local_user_id = m.id
      @training_notifier.system_log_id = @system_log.id
      @training_notifier.isRead = false
      @training_notifier.save
    end
    redirect_to @training
  end

  private
  def session_params
    params.require(:training_session).permit(:datetime, :duration, :level, :length, :location, :recurrence, :enddate)
  end
end
