class Authentication < ActiveRecord::Base
  attr_accessible :provider, :repo_token, :uid, :user_id, :user_token
  
  validates_presence_of :uid, :user_id, :provider, :message => 'is required'


  belongs_to :user
end
