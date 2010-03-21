class StatsController < ApplicationController
  def index
    @wins = PlayerStats.leaders(10)
  end
end
