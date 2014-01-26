module ActiveAdminEventLog
  class ActiveAdminEvent < ActiveRecord::Base
    # Belongs to!
    belongs_to :resource, :polymorphic => true
    belongs_to :author,   :polymorphic => true

    # Attributes
    attr_accessible :resource, :resource_id, :resource_type, :action, :params, :author

    # Serialize params
    serialize :params

    # Get table name
    def self.table_name
      @table_name ||= ActiveRecord::Migrator.proper_table_name("active_admin_events")
    end

    def display_name
      I18n.t("activerecord.models.active_admin_event_log/active_admin_event", :count => 1)
    end
  end
end
