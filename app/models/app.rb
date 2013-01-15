class App < ActiveRecord::Base
  resourcify

  attr_accessible :name, :git_url, :o
  
  has_one :bucket, :dependent => :destroy

  validates :name,
    :presence   => :true,
    :uniqueness => :true,
    :length     => {
      :minimum  => 3,
      :maximum  => 63
    },
    :format     => {
      :with     => /\A[a-z][a-z0-9]*([\-]{1}[a-z0-9]+)*\z/
    },
     :exclusion => { 
      :in => %w(google goog),
      :message => "Name %{value} is reserved."
    }

  before_save :ensure_owner!
  after_save :set_owner, :auto_create_bucket

  # Runs before ActiveRecord#save. Ensures resource has owner.
  def ensure_owner!
    true unless @owner.nil?
  end

  # Set owner (before save).
  def owner=(owner)
    @owner = owner
  end

  # Set owner after save.
  def set_owner
    @owner.add_role(:owner, self) if @owner
  end

  # Use rolify methods to check for role.
  def has_owner?
    self.roles.map(&:name).include?("owner")
  end

  def to_dns
    "#{name}.#{Melang::APP_DOMAIN}"
  end

  def create_bucket
    self.bucket = Bucket.new
  end

  private

  def auto_create_bucket
    self.create_bucket unless self.bucket
  end
end
