source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Template Engine
gem 'haml-rails'

# Bootstrap
gem 'bootstrap-sass'

# Authentication Library
gem 'devise'

# Font Awesome
gem "font-awesome-rails"

# Add a comment summarizing the current schema to the top or bottom of each of your
# - ActiveRecord models
# - Tests and Specs
gem 'annotate', '~> 2.7', '>= 2.7.1'

# Admin interface
gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin'
gem 'inherited_resources', git: 'https://github.com/activeadmin/inherited_resources'
gem "active_material", git: "https://github.com/vigetlabs/active_material"

# Environment variables
gem "figaro"

# Preview email on local
gem 'letter_opener_web', '~> 1.2.0', :group => :development

# Compass SASS
gem 'compass-rails', git: 'https://github.com/Compass/compass-rails'
git 'https://github.com/ably-forks/compass', branch: 'sass-deprecation-warning-fix' do
  gem 'compass-core'
end

gem 'jquery-validation-rails'

gem "wysiwyg-rails"

# Pagination
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap', '~> 1.0', '>= 1.0.1'
# Development and Test
group :development do
  gem 'better_errors'
  gem 'html2haml'
  gem 'rails_layout'
  gem 'binding_of_caller'
end

# Use Passenger as the app server
gem 'passenger'

# Send Server variable to JS
gem 'gon', '~> 6.1'

gem "paperclip", git: "https://github.com/thoughtbot/paperclip.git"

gem 'aws-sdk', '~> 2'

gem 'roadie-rails', '~> 1.0'

gem "dalli"
gem 'memcachier'

gem 'rails_12factor'

# print awesome in rails console
gem 'awesome_print'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
