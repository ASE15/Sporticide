class TrainingsController < ApplicationController

  before_action :authenticate_user!
  before_filter :owns_training!, :only => [:update, :edit, :destroy]

  def index
    @trainings = Training.all
  end

  def show
    @training = Training.find(params[:id])
  end

  def new
    @training = Training.new
  end

  def create
    @training = Training.new(training_params)
    @training.owner = current_user

    @training.cyber_users << current_user #join the training

    if @training.save
      redirect_to @training
    else
      render 'new'
    end
  end

  def edit
    @training = Training.find(params[:id])
  end

  def update
    @training = Training.find(params[:id])

    if @training.update(training_params)
      redirect_to @training
    else
      render 'edit'
    end
  end

  def destroy
    @training = Training.find(params[:id])
    @training.destroy

    redirect_to trainings_path
  end

  def mytrainings
    @trainings = current_user.trainings
    render 'index_private'
  end

  def join
    @training = Training.find(params[:training_id])
    #
    unless @training.cyber_users.exists?(current_user)
      #join
      @training.cyber_users << current_user
      @training.save
      redirect_to @training, :notice => 'You joined this training.'
    else
      #already joined
      redirect_to @training, :error => 'You have already joined this training.'
    end
  end

  def leave
    @training = Training.find(params[:training_id])
    if @training.owner == current_user
      redirect_to @training, :error => 'You cant leave the training because you are the owner!'
    else
      if @training.cyber_users.exists?(current_user)
        @training.cyber_users.delete(current_user)
        redirect_to @training, :notice => 'You have left this training.'
      else
        redirect_to @training, :error => 'You are not member of this training.'
      end
    end
  end

  private
  def training_params
    params.require(:training).permit(:isPublic, :title, :description, :sport)
  end
end