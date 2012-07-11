class App < ActiveRecord::Base
  attr_readonly   :name
  attr_accessible :name, :git_url

  has_one :bucket, :dependent => :destroy

  DOMAIN = 'cli.ent.io'

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

end
