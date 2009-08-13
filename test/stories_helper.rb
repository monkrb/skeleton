require "test_helper"

require "webrat"
require "rack/test"
require "stories"

Webrat.configure do |config|
  config.mode = :rack
end

class Test::Unit::TestCase
  include Webrat::Methods
  include Webrat::Matchers
end
