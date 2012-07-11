class App < ActiveRecord::Base
  attr_accessible :git_url, :name

  DOMAIN = 'ent.io'

  validates :name,
    :presence   => :true,
    :uniqueness => :true,
    :length     => {
      :minimum  => 3,
      :maximum  => 63
    },
    :format     => {
      :with     => /\A[a-z][a-z0-9]*([\-]{1}[a-z0-9]+)*\z/
    }

  def to_dns
    "#{name}.#{DOMAIN}"
  end

  validates :git_url,
    :presence   => :true
end
