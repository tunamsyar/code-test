source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.1'

gem 'active_model_serializers'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'knock'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors'
gem 'rails', '~> 5.2.1'
gem 'rails_admin', '~> 1.3'

group :development, :test do
  gem 'bullet'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard'
  gem 'guard-rspec'
  gem 'pry'
  gem 'pry-rails'
  gem 'rails_best_practices'
  gem 'reek', '= 4.8.0'
  gem 'rubocop', '= 0.53.0'
  gem 'spring-commands-rspec' # https://chodounsky.net/2015/05/01/how-to-speed-up-your-rspec-workflow/
  gem 'zero_downtime_migrations'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec-rails'
  gem 'rspec-sidekiq'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'webmock'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
