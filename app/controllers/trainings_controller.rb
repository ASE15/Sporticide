class TrainingsController < ApplicationController

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
    render 'index_private'
  end

  private
  def training_params
    params.require(:training).permit(:isPublic, :title, :description, :sport)
  end
end