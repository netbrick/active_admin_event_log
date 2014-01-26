# Require
require 'inherited_resources'
require 'active_admin'
require 'active_admin_event_log/default_callbacks'
require 'active_admin_event_log/dirty_resource'

# Require active admin
module ActiveAdminEventLog
  # Load active admin event at point, when Kaminari and Rails are ready!
  autoload :ActiveAdminEvent, 'active_admin_event_log/active_admin_event'
end

# Event - only found option yet ;-(
ActiveAdmin.before_load do |app|
  ActiveAdmin::ResourceDSL.send(:include, ActiveAdminEventLog::DefaultCallbacks)
end
