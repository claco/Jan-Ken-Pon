class Notifications < ActionMailer::Base
  
  def confirmation(email, name, token)
    subject    'Jan Ken Pon Email Confirmation'
    recipients email
    from       'noreply@chrislaco.com'
    sent_on    Time.now
    
    body       :email => email, :name => name, :token => token
  end

  def forgot_password(email, name, token)
    subject    'Jan Ken Pon Password Request'
    recipients email
    from       'noreply@chrislaco.com'
    sent_on    Time.now
    
    body       :email => email, :name => name, :token => token
  end

end
