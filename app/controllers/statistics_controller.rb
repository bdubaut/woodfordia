class StatisticsController < ApplicationController
  def index
    @adventures = Adventure.all.entries
  end
end
