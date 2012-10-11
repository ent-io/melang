require 'spec_helper'

describe Authentication do
 
 before(:each) do 
 
  @user = FactoryGirl.create(:user)
 
  @attr = {
      :user_id => @user.id,
      :provider => "github",
      :uid => "110203303",
    }
      
  end


  it "should create a new instance given a valid attribute" do
    Authentication.create!(@attr)
  end 
  
  
  it "should belongs to some user" do
   
  end
  
  
end