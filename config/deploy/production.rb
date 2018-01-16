server 'sintime.es', user: 'sintimee', roles: %w{app db web}, port: 333

set :deploy_to, '/home/sintimee/ruby/SinTime'
set :rails_env, 'production'
set :branch, ENV['BRANCH'] || 'master'
set :passenger_restart_command, 'sudo /usr/bin/passenger-config restart-app'
set :tmp_dir, '/home/sintimee/tmp'
set :application, 'sintime'