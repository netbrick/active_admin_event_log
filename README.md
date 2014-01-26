# Active Admin Event log for AA 0.6.0

## Info
Active Admin event log

## Installation guide

1. Add gem to gemfile

  ```ruby
  gem 'active_admin_event_log', :git => "https://github.com:netbrick/active_admin_event_log.git"
  ```

2. Run rails generator for create event log migration and create active_admin template (offcourse you'll be able to modify active admin event log resource after that)

  ```ruby
  rails generate active_admin_event_log:install
  ```

3. Run migrations

  ```ruby
  rake db:migrate
  ```

4. Add your translations (you can inspire in config/locales/en.yml)

  ```ruby
  en:
    activerecord:
      models:
        active_admin_event_log/active_admin_event:
          one: "Event log"
          zero: "Event log"
          other: "Events log"
      attributes:
        active_admin_event_log/active_admin_event:
          created_at: "Created at"
          author: "Source user"
      etc...
  ```

5. Add event log to actions! I didn't find yet automatic way for log actions
and batch actions

  ```ruby
    member_action :set_payed do
      # Find order to pay
      order = Order.find(params[:id])

      # Set payed
      order.set_payed

      # Create log
      ActiveAdminEventLog.create_event_record(
        "set_payed",
        order,
        current_active_admin_user,
        { "order" => true } # Dirty detector go through order object and looking for changes
      )

      # Save!
      order.save
    end
  ```
