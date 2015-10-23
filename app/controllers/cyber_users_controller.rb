class CyberUsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /CyberUsers
  # GET /CyberUsers.json
  def index
    if params[:start].nil?
      params[:start] = 0
      params[:size] = 20
    end
    cyber_users = CyberUser.find(:all) #, :params => {:start => params[:start], :size => params[:size]})
  end

  # GET /CyberUsers/1
  # GET /CyberUsers/1.json
  def show
    #nothing to do since we have the set_user method
  end

  # GET /CyberUsers/new
  def new
    cyber_user = CyberUser.new
  end

  # GET /CyberUsers/1/edit
  def edit
    #nothing to do since we have the set_user method
  end

  # POST /CyberUsers
  # POST /CyberUsers.json
  def create
    respond_to do |format|

      #@cyber_user = CyberUser.new({:username => user_params[:username], :email => user_params[:email], :publicvisible => user_params[:publicvisible], :realname => user_params[:realname], :password => user_params[:password]}, true)
      #if user_params[:password] != '*'
      #  @cyber_user.password = user_params[:password]
      #else
      #  @cyber_user.password = nil
      #end
      cyber_user = CyberUser.new(user_params, true)

      begin
        status = cyber_user.save!
      rescue ActiveResource::UnauthorizedAccess,  ActiveResource::ResourceConflict
        status = false
      end

      if status
        format.html { redirect_to :controller => 'sessions', :action => 'new',  notice: 'CyberUser was successfully Created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', alert: "Could not Create" }
        format.json { render json: cyber_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /CyberUsers/1
  # PATCH/PUT /CyberUsers/1.json
  def update
    respond_to do |format|

      cyber_user.email = user_params[:email]
      cyber_user.publicvisible = user_params[:publicvisible]
      cyber_user.realname = user_params[:realname]
      if user_params[:password] != '*'
        cyber_user.password = user_params[:password]
      else
        cyber_user.password = nil
      end


      begin
        status = cyber_user.save
      rescue ActiveResource::UnauthorizedAccess
        status = false
      end

      if status
        format.html { redirect_to cyber_user, notice: 'CyberUser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to cyber_user, alert: "Could not update" }
        format.json { render json: cyber_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /CyberUsers/1
  # DELETE /CyberUsers/1.json
  def destroy
    begin
      status = cyber_user.destroy
    rescue ActiveResource::UnauthorizedAccess
      status = false
    end

    respond_to do |format|
      if status
        session.destroy
        #format.html { redirect_to :controller => 'sessions', :id => session.id, :action => 'destroy' }
        format.html {redirect_to root_path}
        format.json { head :no_content }
      else
        format.html { redirect_to cyber_user, alert: "Could not delete"}
        format.json { render json: cyber_users.errors, status: "Could not delete" }
      end
    end
  end

  def not_found
    flash[:error] = 'No user found'
    redirect_to :action => 'index'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    #CyberUser.cyber_user = session[:user_id]
    #CyberUser.password = session[:passwd]
    Api::Base.user = session[:user_id]
    Api::Base.password = session[:passwd]

    begin
      cyber_user = CyberUser.find(params[:id])
    rescue ActiveResource::ResourceNotFound
      redirect_to :action => 'not_found'
    rescue ActiveResource::ResourceConflict, ActiveResource::ResourceInvalid
      redirect_to :action => 'new'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:cyber_user).permit(:uri, :username, :password, :realname, :email, :publicvisible)
  end

  def sort_column
    Post.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
