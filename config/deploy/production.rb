## settings
set :rails_env, "production" 

## server
set :deploy_to, "/home/emailing/emailing"
set :user, "emailing"
set :domain, "ext.emailingmanagement.com"
server domain, :app, :web
role :db, domain, :primary => true