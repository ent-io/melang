class HomeController < ApplicationController
  
def authorize 

  auth = request.env["omniauth.auth"]
  
  unless auth.blank?
     
      user = get_user auth 
   
      if user.authentications.blank?
          
          user.authentications.create!(
          :uid => auth.uid, 
          :user_token => auth.token,
          :provider => auth.provider )
      
      end
    
    sign_in user
    redirect_to(:action => 'index')
   
  end
 
end
  
  
def get_user(auth)
  
  user = 
      User.where(:email => auth.info.email,
      :name => auth.info.name).first
   
  unless user.present?  
          
      user = User.new
      user.email = auth.info.email
      user.name = auth.info.name
      
      /
          GENERATE A RANDOM PASSWORD WITH THE FUNCTION
          STORE THAT PASSWORD TO USER
          GENERATE A MAILER TO SEND PASSWORD ON USER EMAIL
      /
      
      user.save
      user.confirm!
 
  end
  
  return user
  
end
  
def index
  
  @user = current_user
  
end
  
end
