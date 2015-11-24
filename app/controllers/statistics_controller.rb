class StatisticsController < ApplicationController

  before_action :authenticate_user!

  def index
    @myfriends = current_user.friends

  end
end
