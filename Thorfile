class Monk < Thor
  desc "test", "Run all the tests"
  def test
    $:.unshift File.join(File.dirname(__FILE__), "test")

    Dir['test/**/*_test.rb'].each do |file|
      load file unless file =~ /^-/
    end
  end
end
