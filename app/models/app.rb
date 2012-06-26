class App < ActiveRecord::Base
  attr_accessible :git_url, :name

  validates :name,
    :presence   => :true,
    :uniqueness => :true

  validates :git_url,
    :presence   => :true
end
