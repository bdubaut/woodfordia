class StatisticsController < ApplicationController
  def index
    @adventures = Adventure.all.entries
    @users = User.with_role(:player).all.entries
  end
end
