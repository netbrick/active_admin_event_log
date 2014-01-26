require 'rails/generators/active_record'

module ActiveAdminEventLog
  module Generators
    class InstallGenerator < ActiveRecord::Generators::Base
      # Description and some parameter for run only with "rails g
      # active_admin_event_log:install"
      desc "Installs Active Admin and generates the necessary migrations"
      argument :name, :type => :string, :default => "AdminUser"

      def self.source_root
        File.expand_path("../templates", __FILE__)
      end

      def create_log_migration
        migration_template 'migrations/create_active_admin_event_log.rb', 'db/migrate/create_active_admin_event_log.rb'
      end

      def copy_active_admin_log_template
        template 'active_admin_event_log.rb.erb', 'app/admin/active_admin_event_log.rb'
      end
    end
  end
end


