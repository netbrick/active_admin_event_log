# Require
require 'inherited_resources'
require 'active_admin'
require 'active_admin_event_log/default_callbacks'
require 'active_admin_event_log/dirty_resource'

# Require active admin
module ActiveAdminEventLog
  # Load active admin event at point, when Kaminari and Rails are ready!
  autoload :ActiveAdminEvent, 'active_admin_event_log/active_admin_event'

  # Log helper
  def self.create_event_record(action, resource, author, params = nil)
    # Get parameter difference
    if params
      changed_data = ActiveAdminEventLog::DirtyResource.new(resource, params).hash_report
    else
      changed_data = {}
    end

    # Save event to database
    ActiveAdminEventLog::ActiveAdminEvent.create!(
      :action => action,
      :resource => resource,
      :author => author,
      :params => changed_data
    )
  end

  def self.prepare_object_hash_dump(resource, params = nil)
    begin
      changed_data = {
        type: resource.class.name,
        id:   resource.try(:id),
        data: ActiveSupport::JSON.decode(resource.to_json)
      }
      changed_data = changed_data.to_hash
    rescue => e
      changed_data = {
        type: resource.class.name,
        id: resource.try(:id),
        exception: e.message # Reason why can't serialize!
      }
      # Save params
      changed_data[:params] = params if params

      # Save data
      changed_data = changed_data.to_hash
    end
    changed_data
  end
end

# Event - only found option yet ;-(
ActiveAdmin.before_load do |app|
  ActiveAdmin::ResourceDSL.send(:include, ActiveAdminEventLog::DefaultCallbacks)
end
