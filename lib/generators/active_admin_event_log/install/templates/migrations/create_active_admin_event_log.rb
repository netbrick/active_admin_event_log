class CreateActiveAdminEventLog < ActiveRecord::Migration
  def self.up
    create_table :active_admin_events do |t|
      t.timestamps
      t.string :action, :null => false
      t.text   :params
      t.references :author, :polymorphic => true
      t.string :resource_type, :null => false
      t.string :resource_id, :null => false
    end

    # Indexes
    add_index :active_admin_events, :action
    add_index :active_admin_events, [:author_type, :author_id]
    add_index :active_admin_events, [:resource_type, :resource_id]
  end

  def self.down
    drop_table :active_admin_events
  end
end
