Gem::Specification.new do |s|
  s.name = 'spawn'
  s.version = '0.1.3'
  s.summary = %{Simple fixtures replacement for Sequel, ActiveRecord, Ohm and probably many other ORMs}
  s.description = %{Spawn is a very small library (just 14 lines of code) that can effectively replace fixtures or any other library for the same task.}
  s.authors = ["Michel Martens", "Damian Janowski"]
  s.email = ["michel@soveran.com", "djanowski@dimaion.com"]
  s.homepage = "http://github.com/soveran/spawn"
  s.files = ["lib/spawn.rb", "rails/init.rb", "README.markdown", "LICENSE", "Rakefile", "test/active_record_test.rb", "test/all_test.rb", "test/ohm_test.rb", "test/sequel_test.rb", "spawn.gemspec"]
  s.rubyforge_project = "spawner"
end
