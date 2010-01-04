## ROLES
[ :admin, :agent ].each do |r|
  Factory.define r, :class => Role do |role|
    role.title r.to_s
  end
end

## USERS
[
  {
    :factory_name => :not_activated, :email => 'clewis@authlogic.com', 
    :first_name => 'Carl', :last_name => 'Lewis'
  },
  {
    :factory_name => :ben, :email => 'bjohnson@authlogic.com',
    :first_name => 'Ben', :last_name => 'Johnson'
  },
  {
    :factory_name => :julien,:email => 'julien.biard@gmail.com',
    :first_name => 'Julien', :last_name => 'Biard'
  },
  {
    :factory_name => :aaron, :email => 'aaron@authlogic.com',
    :first_name => 'aaron', :last_name => 'aaron'
  },
  {
    :factory_name => :quentin, :email => 'quentin@authlogic.com',
    :first_name => 'quentin', :last_name => 'quentin'
  },
  {
    :factory_name => :adminuser, :email => 'admin@authlogic.com',
    :first_name => 'admin', :last_name => 'admin', :role => :admin
  },
  {
    :factory_name => :agentuser, :email => 'agent@authlogic.com',
    :first_name => 'agent', :last_name => 'agent', :role => :agent
  },  
].each do |h|
  Factory.define h[:factory_name], :class => User do |u|
    (h.keys - [:factory_name, :role]).each { |k| u.send(k, h[k]) }
    u.password( p = (h[:password] || 'azerty') )
    u.password_confirmation p
    u.roles { |roles| [roles.association(h[:role])] } unless h[:role].nil?
  end
end

## KIT
Factory.define :kit do |k|
  k.association :user, :factory => :adminuser
  k.default_country 'MA'
  k.lang 'fr'
  k.name 'ClubVip'
  k.title 'ClubVip'
  k.finished_at 1.year.since
  k.email_bg_color '#4F78AE'
  k.email_links_color '#FFFFFF'
  k.css File.new("#{RAILS_ROOT}/public/static/stylesheets/kit/style.css")
  k.email1_picture File.new("#{RAILS_ROOT}/public/static/emailing/img/concours.jpg")
  k.email2_picture File.new("#{RAILS_ROOT}/public/static/emailing/img/felicitations.jpg")
end

## SUB
Factory.define :subscription do |s|
  s.civility '03_mister'
  s.email 'john@email.fr'
  s.first_name 'John'
  s.last_name 'Bigood'
  s.region 'Pays de la Loire'
  s.city 'Nantes'
  s.country 'FR'
  s.occupation '01_students'
  s.date_of_birth 20.year.ago
  s.association :kit
end

## CONTACT
Factory.define :contact do |c|
  c.association :subscription
  c.association :kit
  c.email 'toto@email.fr'
  c.source 'Google'
end

## PARTNER
Factory.define :partner do |p|
  p.name 'Parner'
  p.title 'Parner'
  p.description 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  p.association :user, :factory => :adminuser
  p.association :kit
  p.picture File.new(File.join("#{RAILS_ROOT}/public/images", "aol.gif"), 'rb')
end