# Gems
# ==================================================


# For authorization (https://github.com/ryanb/cancan)
gem "cancan"

#For authentication (https://github.com/plataformatec/devise)
gem 'devise'

case ask("Choose Template Engine:", :limited_to => %w[erb haml slim])
when "haml"
  # HAML templating language (http://haml.info)
  gem "haml-rails"
when "slim"
  # A lightweight templating engine (http://slim-lang.com)
  gem "slim-rails"
when "erb"
end

gem_group :development do
  # Rspec for tests (https://github.com/rspec/rspec-rails)
  gem "rspec-rails"
  # Guard for automatically launching your specs when files are modified. (https://github.com/guard/guard-rspec)
  gem "guard-rspec"
end

gem_group :test do
  gem "rspec-rails"
end


# Initialize guard
# ==================================================
run "bundle exec guard init rspec"

# Install Devise
# ==================================================
run "rails g devise:install"

# Generate Devise
# ==================================================
run "rails generate devise User"

# Bootstrap: install from https://github.com/twbs/bootstrap
# Note: This is 3.0.0
# ==================================================
if yes?("Download bootstrap?")
	gem 'devise-bootstrap-views'
  run "wget https://github.com/twbs/bootstrap/archive/v3.0.0.zip -O bootstrap.zip -O bootstrap.zip"
  run "unzip bootstrap.zip -d bootstrap && rm bootstrap.zip"
  run "cp bootstrap/bootstrap-3.0.0/dist/css/bootstrap.css vendor/assets/stylesheets/"
  run "cp bootstrap/bootstrap-3.0.0/dist/js/bootstrap.js vendor/assets/javascripts/"
  run "rm -rf bootstrap"
  run "echo '@import \"bootstrap\";' >>  app/assets/stylesheets/application.css.scss"
  run "rails g simple_form:install --bootstrap"
  
  # Generate Devise Views
	# ==================================================
  run "rails g devise:views:bootstrap_templates"
end


# Ignore rails doc files, Vim/Emacs swap files, .DS_Store, and more
# ===================================================
run "cat << EOF >> .gitignore
/.bundle
/db/*.sqlite3
/db/*.sqlite3-journal
/log/*.log
/tmp
database.yml
doc/
*.swp
*~
.project
.idea
.secret
.DS_Store
EOF"

rake("db:migrate")

run "cat << EOF >> app/assets/stylesheets/application.css
 /**= require bootstrap*/
"
run "cat << EOF >> app/assets/stylesheets/application.css
.panel-default{
  width: 800px;
  margin-left: 100px;
}
.alert{
  width: 800px;
  margin-left: 100px;
}
"