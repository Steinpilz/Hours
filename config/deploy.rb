# config valid only for Capistrano 3.1
lock '3.2.1'

# Check-List
# 1. bundle exec cap :stage deploy:install
# 2. bundle exec cap :stage deploy:setup
# 3. bundle exec cap :stage deploy
# 4. Setup environment variables
# 5. bundle exec cap :stage deploy:before_run

user = "deployer"
application = "hours"

set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

set :application, application
set :user, user
set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache

set :scm, :git
set :repo_url, "git@github.com:ivanbenko/#{application}.git"
set :keep_releases, 5

# set :pty, true
set :ssh_options, {
  forward_agent: true
}

set :rbenv_custom_path, '/home/deployer/.rbenv'
set :rbenv_ruby, '2.2.0'

after "deploy", "deploy:cleanup"

set :bundle_bins, fetch(:bundle_bins, []).push('foreman')
set :foreman_use_sudo, :rbenv
set :foreman_template, 'upstart'
set :foreman_export_path, '/etc/init'
set :foreman_roles, :all
set :foreman_app, -> { fetch(:application) }

set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}

if !fetch(:rvm_map_bins).nil?
  set :rvm_map_bins, fetch(:rvm_map_bins).push('foreman')
end

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

set :linked_files, %w{config/database.yml .env}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" 

require_relative "recipes/base"
require_relative "recipes/nginx"
require_relative "recipes/postgresql"
require_relative "recipes/nodejs"
require_relative "recipes/rbenv"
require_relative "recipes/check"
require_relative "recipes/foreman"
