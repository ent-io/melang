class Bucket < ActiveRecord::Base
  attr_readonly :name, :app_id

  belongs_to :app

  validates :name,
    :presence   =>  :true,
    :uniqueness =>  :true

  validates :app_id,
    :presence   =>  :true,
    :uniqueness =>  :true

  before_create     :put_bucket
  before_destroy    :delete_bucket

  def storage
    @storage ||= nil
  end

  private

  def connection
    @connection ||= Fog::Storage.new({
      :provider                           => 'Google',
      :google_storage_access_key_id       => ENV['GOOGLE_STORAGE_ACCESS_KEY_ID'],
      :google_storage_secret_access_key   => ENV['GOOGLE_STORAGE_SECRET_ACCESS_KEY']
    })
  end

  # TODO(wenzowski): handle bucket creation errors
  def put_bucket
    directory = connection.directories.create(
      :key      =>  name,
      :public   =>  true
    )
    @storage = directory
  end

  # TODO(wenzowski): handle bucket destroy errors
  # eg. 409 bucket not empty
  # directory.files.each {|f| f.destroy}
  def delete_bucket
    directory = connection.directories.find(:name => name).first
    directory.destroy
    @storage = nil
  end

  # TODO(wenzowski): set website configuration
  # https://developers.google.com/storage/docs/website-configuration

end
