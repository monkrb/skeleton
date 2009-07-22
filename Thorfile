class MonkTasks < Thor
  namespace :monk

  include Thor::Actions

  SETTINGS = "config/settings.yml"
  SETTINGS_SAMPLE = "config/settings.example.yml"

  desc "test", "Run all the tests"
  def test
    invoke :verify_settings

    $:.unshift File.join(File.dirname(__FILE__), "test")

    Dir['test/**/*_test.rb'].each do |file|
      load file unless file =~ /^-/
    end
  end

  desc "verify_settings", "Verify the existance of the settings file"
  def verify_settings
    return if File.exists?(SETTINGS)
    say_status :missing, SETTINGS
    create_settings
  end

private

  def self.source_root
    File.dirname(__FILE__)
  end

  def create_settings
    return unless File.exists?(SETTINGS_SAMPLE)

    if yes?("Do you want to copy the file #{SETTINGS_SAMPLE} to #{SETTINGS}?")
      copy_file SETTINGS_SAMPLE, SETTINGS
    end
  end
end
