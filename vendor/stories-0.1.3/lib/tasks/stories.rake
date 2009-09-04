Rake::TestTask.new(:stories => "db:test:prepare") do |t|
  t.libs << "test"
  t.options = "--runner=stories"
  t.pattern = 'test/integration/**/*_test.rb'
  t.verbose = false
end
Rake::Task['stories'].comment = "Run and print the UATs"

namespace :stories do
  Rake::TestTask.new(:pdf => "db:test:prepare") do |t|
    t.libs << "test"
    t.options = "--runner=stories-pdf"
    t.pattern = 'test/integration/**/*_test.rb'
    t.verbose = false
  end
  Rake::Task['stories:pdf'].comment = "Run UATs and produce a nice PDF"
end
