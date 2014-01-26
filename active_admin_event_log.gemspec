# -*- encoding: utf-8 -*-
require File.expand_path('../lib/active_admin_event_log/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'active_admin_event_log'
  s.version = ActiveAdminEventLog::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = %w("Jan Strnádek")
  s.email = %w(jan.strnadek@gmail.com)
  s.homepage = 'https://github.com/netbrick/active_admin_event_log'
  s.summary = 'Active Admin event logger'
  s.description = 'Active Admin event logger'

  s.required_rubygems_version = '>= 1.3.6'

  # Gems
  s.add_dependency 'activeadmin', '~> 0.6.0'

  s.add_development_dependency 'bundler', '>= 1.0.0'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rake'

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").map { |f| f =~ /^bin\/(.*)/ ? $1 : nil }.compact
  s.require_path = 'lib'
end
