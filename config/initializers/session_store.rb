# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_jkp_session',
  :secret      => '3bdfa4bdaef69eb9cea6e8af1ee41ba5a4bf4f9cbd0723cf6c0708d3a96f3eba4ce43928397fb2d41588b9096e796c6085835fef597ea6ea488146a71c7ff9c8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
