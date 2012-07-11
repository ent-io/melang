class Bucket < ActiveRecord::Base
  attr_readonly :name, :app_id

  belongs_to :app

  validates :name,
    :presence   => :true,
    :uniqueness => :true

  validates :app_id,
    :presence   => :true,
    :uniqueness => :true

end
