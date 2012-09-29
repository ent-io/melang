class HomeController < ApplicationController
  
def auth 
  auth = request.env["omniauth.auth"]
    
  user = User.where(:email => auth.info.email, :name => auth.info.name).first
 
  unless user  
  
    user = User.new
    user.email = auth.info.email
    user.name = auth.info.name
    user.save
    user.confirm!
    
  end
  
  sign_in user
  redirect_to(:action => 'index')
 
end
  
def index
  
  @user = current_user
  
end
  
end
