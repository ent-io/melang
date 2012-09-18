require 'spec_helper'

describe HomeController do

	describe 'authenticated user' do
	  login_user
	  
	  describe "GET 'index'" do
	    it "should be successful" do
	      get 'index'
	      response.should be_success
	    end
	  end
	end  # authenticated user

	describe 'UN-authenticated user' do
		describe "GET 'index'" do
	    it "should be successful" do
	      get 'index'
	      response.should_not be_success
	    end
	  end		
	end  # UN-authenticated user

end
