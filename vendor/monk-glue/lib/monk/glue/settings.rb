require 'yaml'

def monk_settings(key)
  $monk_settings ||= YAML.load_file(root_path("config", "settings.yml"))[RACK_ENV.to_sym]

  unless $monk_settings.include?(key)
    message = "No setting defined for #{key.inspect}."
    defined?(logger) ? logger.warn(message) : $stderr.puts(message)
  end

  $monk_settings[key]
end

