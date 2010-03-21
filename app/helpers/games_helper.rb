module GamesHelper
  include ApplicationHelper

  def render_open_games
    render :partial => "games/open_games", :locals => { :games => GameQueue.open_games }
  end

  def render_my_open_games
    if authenticated?
      render :partial => "games/my_open_games", :locals => { :games => current_player.open_games }
    end
  end

  def render_top_winners(max=5)
    render :partial => "stats/top_winners", :locals => { :stats => PlayerStats.leaders(max) }
  end

  def render_create_game(mode=1)
    render :partial => "games/create_game", :locals => { :mode => mode }
  end
end
