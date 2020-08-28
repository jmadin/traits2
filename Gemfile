source 'https://rubygems.org'

ruby '2.7.1'

gem 'rails'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'jquery-turbolinks'
gem 'webpacker'

gem 'bootstrap-sass'
gem 'bcrypt'
gem 'cocoon'
gem 'will_paginate'
gem 'bootstrap-will_paginate'

gem 'select2-rails'
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'progress_bar'
gem 'redcarpet'
gem 'google_visualr'
gem 'semantic'

gem 'savon'

# gem 'capistrano',  '~> 3.1'
# gem 'capistrano-rails', '~> 1.1'

gem 'colorize'
gem 'seed_dump'

gem 'roo'

# using paper_trail for database versioning
gem 'paper_trail'

# using google analytics gem
gem 'google-analytics-rails'

# using zip to send multiple csv files in one click
gem 'rubyzip'
gem 'zip-zip'

# for prettifying the rails console output
# Include the following code into ~/.irbrc file, so that everytime you start rails console, the hirb view is automatically loaded
# require 'hirb'
# View class needs to come before enable()
# class Hirb::Helpers::Yaml; def self.render(output, options={}); output.to_yaml; end ;end
# Hirb.enable :output=>{"Hash"=>{:class=>"Hirb::Helpers::Yaml"}}
gem 'hirb'

# for sharding database (main database and temporary database)
#gem "ar-octopus", :git => "git://github.com/tchandy/octopus.git", :require => "octopus"

gem 'pg',             '0.17.1'

# database setup (postgres), and for Heroku
group :production do
  gem 'rails_12factor', '0.0.2'
  # gem 'puma',           '3.1.0'
end

group :development, :test do

  gem 'minitest'
  gem 'spring'
  gem 'sqlite3'
  gem 'listen'

end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.0'
  # gem 'database_cleaner', github: 'bmabey/database_cleaner'

  # Uncomment this line on OS X.
  # gem 'growl', '1.0.3'

  # Uncomment these lines on Linux.
  # gem 'libnotify', '0.8.0'

  # Uncomment these lines on Windows.
  # gem 'rb-notifu', '0.0.4'
  # gem 'win32console', '1.3.2'
  # gem 'wdm', '0.1.0'
end

gem 'sdoc', '~> 0.4.0',          group: :doc
