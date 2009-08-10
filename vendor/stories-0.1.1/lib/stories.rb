require "rubygems"
require "contest"

unless defined?(Test::Unit::AutoRunner)
  gem "test-unit", ">= 1.2"
end

class Test::Unit::TestCase
  class << self
    alias story context
    alias scenario test
  end
end

Test::Unit::AutoRunner::RUNNERS[:stories] = proc do |r|
  puts "Story runner not found. You need to require 'stories/runner'."
end

Test::Unit::AutoRunner::RUNNERS[:"stories-pdf"] = proc do |r|
  puts "Story runner not found. You need to require 'stories/runner'."
end
