if RAILS_ENV == 'test'

  require File.dirname(__FILE__) + "/../lib/stories/runner"

  # Require webrat and configure it to work in Rails mode.
  require "webrat"

  Webrat.configure do |config|
    config.mode = :rails
  end

  ActionController::IntegrationTest.send(:include, Stories::Webrat)
end
