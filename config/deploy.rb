# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'test_app'
set :repo_url, 'git@github.com:shiva-chaganti/test_app.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
 set :deploy_to, '/var/www/test_app'

# Default value for :scm is :git
 set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
 set :pty, true

# Default value for :linked_files is []
 set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
 set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')


set :rbenv_type, :user
set :rbenv_ruby, '2.3.0'
set :rbenv_custom_path, '/root/.rbenv/bin/'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_custom_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_custom_path)}/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value


set :passenger_environment_variables, { :path => '/root/.rbenv/shims/passenger:$PATH' }
set :passenger_restart_command, '/root/.rbenv/shims/passenger-config restart-app'

# Default value for default_env is {}
 set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
