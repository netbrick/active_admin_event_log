module ActiveAdminEventLog
  module ResourceDataAccessPatch
    def self.included(base)
      base.class_eval do
        # Try to alias
        alias_method :update_resource_wihout_log, :update_resource
        alias_method :update_resource, :update_resource_with_log

        def update_resource_with_log
          puts "AHOJ\n\n\n"
          Rails.logger.debug "TEst\n\n\n"
          update_resource_without_log
          Rails.logger.deubg "OK\n\n\n"
          puts "OK\n\n\n"
        end




        def create_active_admin_event(object)
          Rails.logger.debug "VOLANO!!\n"
        end
      end
    end
  end
end
