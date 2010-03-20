class AuthenticationController < ApplicationController
  def login
    if request.post?
        @user_session = UserSession.new(params[:User])
        if @user_session.save
          redirect_to root_url
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
