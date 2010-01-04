# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_emailing_session',
  :secret      => '54e7c3d9411ac15cc0fa20d4722c1c0e82edf13f3c9afc8c3ba4058dd2da4034dce0e5e7b668c80f2137d952c736453e7027fa9d3b64eb41308ef9c468f6cac0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
