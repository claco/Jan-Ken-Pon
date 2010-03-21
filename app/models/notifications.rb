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

  def invitation(email, from_player)
    subject    'Jan Ken Pon Invitation'
    recipients email
    from       'noreply@chrislaco.com'
    sent_on    Time.now
    
    body       :email => email, :player => from_player
  end
  
  def game_invitation(game, email, from_player)
    subject    'Jan Ken Pon Game Invitation'
    recipients email
    from       'noreply@chrislaco.com'
    sent_on    Time.now
    
    body       :game => game, :email => email, :player => from_player
  end

end
