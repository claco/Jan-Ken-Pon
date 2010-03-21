class User < ActiveRecord::Base
  has_one :player

  attr_accessor :password_confirmation 

  acts_as_authentic do |c|
    c.require_password_confirmation = false
    c.validate_email_field = false
    c.validate_password_field = false
    c.disable_perishable_token_maintenance = true
  end

  validates_presence_of :name, :message => 'Name is required'
  validates_presence_of :email, :message => 'Email address is required'
  validates_presence_of :password, :message => 'Password is required'
  validates_format_of :email, :with => Authlogic::Regex.email, :message => 'Email address is invalid', :unless => Proc.new { |user| user.email.blank? }
  validates_uniqueness_of :email, :message => 'Email address already exists'

  def before_create
    if perishable_token.blank?
      reset_perishable_token
    end
  end

  def confirm!
    confirm
    reset_perishable_token!
  end
  
  def confirm
    self.confirmed = true
  end
end
