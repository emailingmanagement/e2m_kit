## settings
set :rails_env, "staging" 

## server
set :deploy_to, "/home/railsdev/sites/emailing"
set :user, "railsdev"
set :domain, "#{application}.agiliweb.com"
server domain, :app, :web
role :db, domain, :primary => true