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
end
