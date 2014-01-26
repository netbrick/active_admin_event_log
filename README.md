# Active Admin Event logger for Active Admin 0.6.0 (maybe 0.6.1)

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
