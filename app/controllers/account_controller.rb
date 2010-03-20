class AccountController < ApplicationController
  include ApplicationHelper

  def create
    if request.post?
        @user = User.new(params[:User])

        if @user.save
          flash[:notice] = 'Account created successfully. A confirmation email has been sent to ' + @user.email
          
          Notifications.deliver_confirmation(@user.email, @user.name, @user.perishable_token)
          
          redirect_to account_path
        end
    end
  end
  
  def edit
    if request.post?
      @user = current_user

      email = params[:User][:email]
      password = params[:User][:password]
      confirm = params[:User][:confirm_password]
      
      if !email.blank?
        existing = User.find_by_email(email)
        
        if existing.blank?
          @user.email = email
          @user.confirmed = false
          @user.save(false)

          flash[:notice] = 'Account updated successfully. A confirmation email has been sent to ' + @user.email
        
          Notifications.deliver_confirmation(@user.email, @user.name, @user.perishable_token)
        
          redirect_to account_path
        else
          flash.now[:notice] = 'Email address already exists!'
        end
      end
      
      if !password.blank?
        if password != confirm
          flash.now[:notice] = 'Passwords do not match'
        else
          @user.password = password
          @user.save
          
          flash[:notice] = 'Account updated successfully. You password has been changed.'
          
          redirect_to account_path
        end
      end
    end
  end
  
  def confirm
    user = User.find_using_perishable_token(params[:token])

    if user.blank?
      flash.now[:notice] = 'Could not find account to activate.'
    else
      user.confirm!

      flash.now[:notice] = 'Your email address has been confirmed.'
    end
  end

  def resend
    if authenticated?
      @user = current_user
      @user.reset_perishable_token!
      Notifications.deliver_confirmation(@user.email, @user.name, @user.perishable_token)
      flash.now[:notice] = 'A conformation email has been sent to ' + @user.email
    end
  end

  def forgot
    if !authenticated? && request.post?
      @user = User.find_by_email(params[:User][:email])
      if @user.blank?
        flash.now[:notice] = 'Could not find account to reset'
      else
        @user.reset_perishable_token!
        Notifications.deliver_forgot_password(@user.email, @user.name, @user.perishable_token)
        flash.now[:notice] = 'A password reset email has been sent to ' + @user.email
      end
    end
  end

  def reset
    user = User.find_using_perishable_token(params[:token])

    if user.blank?
      flash.now[:notice] = 'Could not find account to reset.'
    else
      if request.post?
        password = params[:User][:password]
        confirm = params[:User][:confirm_password]
        
        if password.blank? || password != confirm
          flash.now[:notice] = 'Your passwords do not match.'
        else
          user.password = password
          user.save

          flash.now[:notice] = 'Your password has been changed.'
        end
      end
    end
  end
end
