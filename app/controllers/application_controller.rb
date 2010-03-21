# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
include ApplicationHelper

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  def requires_authentication
    redirect_to login_url unless authenticated?
  end
end
