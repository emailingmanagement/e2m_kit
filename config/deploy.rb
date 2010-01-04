set :stages, %w(staging production)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "e2m_kit"

## settings
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

## git
set :scm, :git
set :deploy_via,  :remote_cache
set :scm_verbose, true
set :use_sudo,    false
set :branch,     'master'
set :repository, "git@github.com:emailingmanagemet/#{application}.git"

##
after 'deploy:update_code' do 
  run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "ln -s #{shared_path}/att #{release_path}/public/att"
end

namespace :deploy do
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end
