source 'https://rubygems.org'

gem 'rails', '3.2.8'

group :assets do
  gem 'sass-rails',             '~> 3.2.3'
  gem 'coffee-rails',           '~> 3.2.1'
  gem 'uglifier',               '>= 1.0.3'
end

gem 'jquery-rails'
gem 'bootstrap-sass',           '>= 2.1.0.0'
gem 'hominid',                  '>= 3.0.5'
gem 'devise',                   '>= 2.1.2'
gem 'cancan',                   '>= 1.6.8'
gem 'rolify',                   '>= 3.2.0'
gem 'simple_form',              '>= 2.0.2'
gem 'google_visualr',           '>= 2.1.2'
gem 'jquery-datatables-rails',  '>= 1.11.0'
gem 'slim',                     '>= 1.3.0'
gem 'fog',                      '>= 1.5.0'

# Use the correct web server for the current platform.
gem 'thin',               :require => false,  :platforms => :ruby
gem 'trinidad',           :require => false,  :platforms => :jruby

group :production do
  gem 'pg',                                   :platforms => :ruby
  gem 'activerecord-jdbcpostgresql-adapter',  :platforms => :jruby
  gem 'newrelic_rpm'
end

group :development do
  gem 'guard-rspec',            '>= 1.2.1'
  gem 'launchy',                '>= 2.1.2'
  gem 'ruby-debug',             '>= 0.10.4',  :platform => :mri_18
  gem 'debugger',               '>= 1.2.0',   :platform => :mri_19
  gem 'simplecov'
  gem 'mailcatcher'

  # Send system notifications on Linux, OSX, and Windows
  # with Growl >= 1.3, Growl for Linux/Windows, and Snarl
  gem 'ruby_gntp'

  # Watch file change events instead of polling
  gem 'rb-fsevent', :require => false, :group => :darwin              # OSX
  gem 'rb-inotify', :require => false, :group => :linux               # Linux
  gem 'wdm',        :require => false, :platforms => [:mswin, :mingw] # Windows
  # See https://github.com/carlhuda/bundler/wiki/Platform-as-a-parameter

  # Color terminal output on Windows
  gem 'win32console', :platforms => [:mswin, :mingw] 
end

group :development, :test do
  gem 'email_spec',             '>= 1.2.1'
  gem 'capybara',               '>= 1.1.2'
  gem 'database_cleaner',       '>= 0.8.0'
  gem 'cucumber-rails',         '>= 1.3.0', :require => false
  gem 'rspec-rails',            '>= 2.11.0'
  gem 'fuubar',                 '>= 1.0.0'
  gem 'factory_girl_rails',     '>= 4.0.0'
  gem 'shoulda-matchers',     # '>= 1.3.1' not yet released
    :git    => 'git://github.com/thoughtbot/shoulda-matchers.git'

  platforms :jruby do
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbcmysql-adapter'
    gem 'activerecord-jdbcpostgresql-adapter'
    gem 'jruby-openssl'
  end

  platforms :ruby do
    gem 'sqlite3'
    gem 'mysql2'
    gem 'pg'
  end
end
