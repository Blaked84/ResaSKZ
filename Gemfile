source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.10'

# Use sqlite3 as the database for Active Record
# Use MySQL2 as the database for Active Record
# gem 'mysql2', '~> 0.3.18' # NOT USED

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Assets
gem 'material-icons-rails'
#gem 'rails-assets-materialize', source: 'https://rails-assets.org'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'execjs'
gem 'therubyracer', :platforms => :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Authentification
gem 'devise'
gem 'omniauth'
gem "omniauth-cas", :git => "https://github.com/loocla/omniauth-cas.git", :branch => 'saml'

# Authorisation
gem 'cancan'
gem 'rolify', '~> 4.0.0'

gem 'haml-rails'
gem 'configurable_engine'
gem 'figaro'
# pour les charts sur la page admin
gem "chartkick"
gem 'groupdate'

gem "binding_of_caller", "~> 0.7.2"

gem 'will_paginate', '~> 3.0.0'

gem 'actionpack-action_caching'

gem 'addressable'

gem 'simple_form'


#Autocompletion pour les form de recherche
gem 'rails4-autocomplete'

gem 'ean13'
# generation des codes bare
gem 'barby', '~> 0.5.1'
gem 'chunky_png'

# pdf
gem 'prawn', '~> 1.2.1'
gem 'prawn-table', '~> 0.1.0'

# export db en yaml
gem 'yaml_db', github: 'jetthoughts/yaml_db', ref: 'fb4b6bd7e12de3cffa93e0a298a1e5253d7e92ba'

# pour gérer plus facilement les asset de fonts qui ne sont pas precompilés et qui ne changement jamais
#gem "non-stupid-digest-assets"

# pour passer des variables ruby dans un js
gem 'gon'

#accès au routes depuis js
gem "js-routes"

# Pour faire du temps réél
#gem 'faye'
#gem 'thin', require: false
#gem 'sync'

# Pour la gestion des erreurs
gem 'exception_handler'


#Ajouter gem de recherche pour active record

group :development do

	gem 'sqlite3'

	gem 'better_errors'

	gem 'rails-erd' #pour les diagramme UML

	gem 'rails-footnotes', '>= 3.7.9'

	gem 'rack-mini-profiler'

	gem 'flamegraph'

	gem 'stackprof'

	gem 'hirb' #better cli table view for db

end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
