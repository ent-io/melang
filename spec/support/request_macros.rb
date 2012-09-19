module RequestMacros
  
	include Warden::Test::Helpers
	Warden.test_mode!
  
  # for use in request specs, not controller specs
  def sign_in_as_user(user=nil)
  	u = user || :user
		user = FactoryGirl.create(u)
		page.driver.post user_session_path, :user => { :email => user.email, :password => user.password }
  end
end
