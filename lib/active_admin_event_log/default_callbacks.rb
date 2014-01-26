# Add methods!
module ActiveAdminEventLog
  module DefaultCallbacks
    def self.included(base)
      base.class_eval do
        def set_log_callbacks
          [ :update, :destroy, :create ].each do |action|
            @config.controller.send("before_#{action}") do |resource|
              # Prepare changed values
              changed_data = ActiveAdminEventLog::DirtyResource.new(resource, params).hash_report

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

        def initialize(config)
          @config = config
          set_log_callbacks
        end
      end
    end
  end
end
