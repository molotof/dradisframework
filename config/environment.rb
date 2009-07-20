# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Uncomment to really force rails into production mode. See:
#   ./vendor/rails/railties/lib/commands/servers/webrick.rb#56
#ENV["RAILS_ENV"] = 'production'
#RAILS_ENV.replace('production') if defined?(RAILS_ENV)


# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '2.0.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use (only works if using vendor/rails).
  # To use Rails without a database, you must remove the Active Record framework
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_server_session',
    :secret      => 'bd8110b6339930a5d86ad0526fef74cbb546ae2080c57eb6af09569ab8697bec440912681fa28ef4b47295242a98cd1c1e1c69df4f122e4b6793bf473997bcad'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # FIX from http://robsanheim.com/2008/01/08/rails-observers-make-rake-dbmigrate-crash-from-version-0/
  # to prevent rake db tasks from loading the observer (uses the 
  # 'configurations' table not available until revision 4)
  if (
       (File.basename($0) == 'rake') && 
       (%w{create drop migrate reset}.any? { |task| ARGV.include?("db:#{task}")||ARGV.include?("dradis:#{task}") })
     ) 
    # running rake, disable import/export plugins
    config.plugins = [ ]
  else
    config.active_record.observers = :revision_observer 
  end

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
end
