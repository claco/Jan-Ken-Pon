# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_user
    return @current_user if defined?(@current_user)
    
    @current_user_session = UserSession.find unless defined?(@current_user_session)
    @current_user = @current_user_session && @current_user_session.user
  end
  
  def current_player
    current_user.player
  end

  def authenticated?
    if current_user
      return true
    else
      return false
    end
  end
end
