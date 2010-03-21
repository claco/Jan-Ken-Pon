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

  def periodically_check_for_opponent
code =<<END
  var checkForOpponent = true;
  function onCheckForOpponentComplete(request) {
    response = request.responseText.evalJSON(true);
    if (response.game.opponent_id) {
      location.reload();
    };
  };
END

    concat(javascript_tag(code))
    periodically_call_remote(:url => play_game_url(@game.key, :format => :json), :frequency => '5', :condition => "checkForOpponent == true", :success => 'onCheckForOpponentComplete(request)')
  end
end
