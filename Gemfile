source 'https://rubygems.org'

gem 'rails', '3.2.11'

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

group :production do
  gem 'thin',                   '>= 1.4.1'
end

group :test do
  gem 'capybara',               '>= 1.1.2'
  gem 'email_spec',             '>= 1.2.1'
  gem 'cucumber-rails',         '>= 1.3.0', :require => false
  gem 'database_cleaner',       '>= 0.8.0'
  gem 'launchy',                '>= 2.1.2'
end

group :development, :test do
  gem 'rspec-rails',            '>= 2.11.0'
  gem 'factory_girl_rails',     '>= 4.0.0'

  platforms :jruby do
    gem 'activerecord-jdbcsqlite3-adapter'
    gem 'activerecord-jdbcmysql-adapter'
    gem 'activerecord-jdbcpostgresql-adapter'
    gem 'jruby-openssl'
  end

  unless defined?(JRUBY_VERSION)
    gem 'sqlite3'
    gem 'mysql2'
    gem 'pg'
  end

  platforms :mswin, :mingw do
    gem 'win32console'
    gem 'rb-fchange', '~> 0.0.5'
    gem 'rb-notifu', '~> 0.0.4'
  end

  platforms :ruby do
    gem 'spork', '0.9.0.rc9'
    gem 'guard-spork'
    unless ENV['TRAVIS']
      gem 'mailcatcher'
      
      require 'rbconfig'
      if RbConfig::CONFIG['target_os'] =~ /darwin/i
        gem 'rb-fsevent', '>= 0.3.9'
        gem 'growl',      '~> 1.0.3'
      end
      if RbConfig::CONFIG['target_os'] =~ /linux/i
        gem 'rb-inotify', '>= 0.5.1'
        gem 'libnotify',  '~> 0.1.3'
        gem 'therubyracer', '~> 0.9.9'
      end
    end
  end

  platforms :jruby do
    unless ENV['TRAVIS']
      require 'rbconfig'
      if RbConfig::CONFIG['target_os'] =~ /darwin/i
        gem 'growl',      '~> 1.0.3'
      end
      if RbConfig::CONFIG['target_os'] =~ /linux/i
        gem 'rb-inotify', '>= 0.5.1'
        gem 'libnotify',  '~> 0.1.3'
      end
    end
  end

end
