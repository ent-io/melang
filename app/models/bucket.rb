class Bucket < ActiveRecord::Base
  attr_readonly :name, :app_id
  attr_accessible :name

  belongs_to :app

  validates :name,
    :presence   =>  :true,
    :uniqueness =>  :true

  validates :app_id,
    :presence   =>  :true,
    :uniqueness =>  :true

  state_machine :state, :initial => :removed do
    state :removed,     :value => 0   # bucket does not exist
    state :provisioned, :value => 1   # bucket exists
    state :configured,  :value => 2   # a webcfg has been applied to bucket
    state :deployed,    :value => 3   # data has been uploaded to the bucket

    event :provision do
      transition :removed => :provisioned
    end
    event :configure do
      transition :provisioned => :configured
    end
    event :remove do
      transition [:configured, :provisioned] => :removed
    end
    event :upload_files do
      transition [:configured, :deployed] => :deployed
    end
    event :delete_all_files do
      transition [:deployed, :configured] => :configured
    end

    before_transition :removed  => :provisioned, :do => :put_bucket
    before_transition :provisioned => :configured, :do => :put_bucket_webcfg
    before_transition [:configured, :provisioned] => :removed, :do => :delete_bucket
    before_transition :deployed => :configured, :do => :delete_bucket_files
  end
  after_create      :provision, :configure
  before_destroy    :delete_all_files, :remove
  after_initialize  :init

  private

  def init
    self.name ||= "#{uuid.generate}.#{Melang::BUCKET_DOMAIN}"
  end

  def uuid
    @uuid ||= UUID.new
  end

  def fog_connection
    @fog_connection ||= Fog::Storage.new({
      :provider                           => 'Google',
      :google_storage_access_key_id       => ENV['GOOGLE_STORAGE_ACCESS_KEY_ID'],
      :google_storage_secret_access_key   => ENV['GOOGLE_STORAGE_SECRET_ACCESS_KEY']
    })
  end

  def fog_directory
    return nil if self.removed?
    @fog_directory ||= fog_connection.directories.find(:name => self.name).first
  end

  # TODO(wenzowski): handle bucket creation errors
  def put_bucket
    @fog_directory = fog_connection.directories.create(
      :key      =>  self.name,
      :public   =>  true
    )
  end

  def delete_bucket_files
    fog_directory.files.each { |f| f.destroy }
  end

  def delete_bucket
    fog_directory.destroy
  end

  # TODO(wenzowski): set website configuration
  # https://developers.google.com/storage/docs/website-configuration
  def put_bucket_webcfg
    # raise NotImplementedError
  end

end
