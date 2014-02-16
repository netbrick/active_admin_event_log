# Add methods!
module ActiveAdminEventLog
  module DefaultCallbacks
    def self.included(base)
      base.class_eval do
        def set_log_callbacks
          [ :update, :destroy ].each do |action|
            @config.controller.send("before_#{action}") do |resource|
              # Resource is valid - will be saved!
              if resource.valid?
                # If destroy dump data!
                if action == :destroy
                  changed_data = ActiveAdminEventLog.prepare_object_hash_dump resource
                else
                  # Prepare changed values
                  changed_data = ActiveAdminEventLog::DirtyResource.new(resource, params).hash_report
                end

                # Create event log
                ActiveAdminEventLog::ActiveAdminEvent.create!(
                  :author => current_active_admin_user,
                  :resource => resource,
                  :action => action,
                  :params => changed_data
                )
              end
            end
          end

          @config.controller.send("after_create") do |resource|
              # Nohting to do when resource is invalid?!
              if resource.errors.empty?
                # Get changed data
                changed_data = ActiveAdminEventLog.prepare_object_hash_dump resource, params

                # Create event log
                ActiveAdminEventLog::ActiveAdminEvent.create!(
                  :author => current_active_admin_user,
                  :resource => resource,
                  :action => "create",
                  :params => changed_data
                )
              end
          end
        end

        def initialize(config, resource_class)
          @resource = resource_class
          super(config)
          set_log_callbacks
        end
      end
    end
  end
end
