class UserMailer < ActionMailer::Base
  default :from => "Melang App <melang@ent.io>"

  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
  end
end
