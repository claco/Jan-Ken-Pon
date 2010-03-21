class AuthenticationController < ApplicationController
  include ApplicationHelper

  def login
    #TODO before_filter

    if authenticated?
      game = params[:game]
      if game.blank?
        redirect_to root_url
      else
        redirect_to join_game_url(game)
      end
    end

    if request.post?
        @user_session = UserSession.new(params[:User])
        if @user_session.save
          if params[:game].blank?
            redirect_to root_url
          else
            redirect_to join_game_path(params[:game])
          end
        else
          flash.now[:notice] = 'Invalid email address or password'
        end
    end
  end
  
  def logout
    @user_session = UserSession.find
    
    if !@user_session.blank?
      @user_session.destroy
    end

    redirect_to root_url
  end
end
