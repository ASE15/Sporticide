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

    @training.users << current_user #join the training

    if @training.save
      subscribe_user_to_sport(current_user, @training.sport)

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
    unless @training.users.exists?(current_user)
      #join
      @training.users << current_user
      if @training.save
        subscribe_user_to_sport(current_user, @training.sport)
        redirect_to @training, :notice => 'You joined this training.'
      else
        redirect_to @training, :alert => 'There was a problem!'
      end
    else
      #already joined
      redirect_to @training, :alert => 'You have already joined this training.'
    end
  end

  def leave
    @training = Training.find(params[:training_id])
    if @training.owner == current_user
      redirect_to @training, :alert => 'You cant leave the training because you are the owner!'
    else
      if @training.users.exists?(current_user)
        @training.users.delete(current_user)
        redirect_to @training, :notice => 'You have left this training.'
      else
        redirect_to @training, :alert => 'You are not member of this training.'
      end
    end
  end

  def invite
    @training = Training.find(params[:training_id])
    @friend = LocalUser.find(params[:par1])
    #
    unless @training.users.exists?(@friend)
      #join
      @training.users << @friend
      if @training.save
        subscribe_user_to_sport(@friend, @training.sport)
        redirect_to @training, :notice => 'Your friend was successfully added to the training.'
      else
        redirect_to @training, :alert => 'There was a problem!'
      end
    else
      #already joined
      redirect_to @training, :alert => 'Your friend already joined the training!'
    end
  end

  private
  def training_params
    params.require(:training).permit(:isPublic, :title, :description, :sport)
  end

  def subscribe_user_to_sport(user, sport)
    cc_user = session[:user_id]
    cc_pass = session[:passwd]

    #ToDo insert real username
    begin
      digest = Base64.encode64(cc_user+':'+cc_pass)
      url = "http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/users/#{cc_user}/#{sport}"
      doc = RestClient.put url, {:publicvisible => 2}, {:Authorization => "Basic #{digest}"}

      Rails.logger.debug("answer: #{doc}")

      #doc = Nokogiri::XML(result)

    rescue Exception => e
      status=false
      Rails.logger.debug("error: #{e}")
    end
  end
end
