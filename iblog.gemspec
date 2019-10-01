$:.push File.expand_path('../lib', __FILE__)
require 'iblog/version'

Gem::Specification.new do |s|
  s.name        = 'iblog'
  s.version     = Iblog::VERSION
  s.authors     = ['Marc Jansing']
  s.email       = ['marc.jansing@innoq.com']
  s.homepage    = 'https://github.com/innoq/iblog'
  s.summary     = 'Internal Corporate Blogging & PPP.'
  s.description = 'Simple internal blogging/PPP solution.'
  s.license     = 'Apache License 2.0'

  s.files = Dir['{app,config,db,lib}/**/*', 'Rakefile']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 5.1.7'
  s.add_dependency 'mysql2'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'kaminari'
  s.add_dependency 'kaminari-i18n'
  s.add_dependency 'rails-i18n'
  s.add_dependency 'redcarpet'
  s.add_dependency 'acts-as-taggable-on', '~> 5.0.0'
  s.add_dependency 'simple_form', '~> 5.0.0'
  s.add_dependency 'sass-rails'
  s.add_dependency 'bootstrap', '~> 4.1.3'
  s.add_dependency 'autoprefixer-rails', '~> 8.6.5'

  s.add_dependency 'uglifier', '>= 1.3.0'
  s.add_dependency 'therubyracer'
  s.add_dependency 'coffee-rails', '~> 4.2.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'letter_opener'
  s.add_development_dependency 'addressable'
  s.add_development_dependency 'capybara', '~> 2.11.0'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'web-console', '~> 3.4.0'
  s.add_development_dependency 'spring'
  s.add_development_dependency 'pry-rails'
end
