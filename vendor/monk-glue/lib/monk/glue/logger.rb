require 'logger'

def logger
  $logger ||= begin
    $logger = ::Logger.new(root_path("log", "#{RACK_ENV}.log"))
    $logger.level = ::Logger.const_get((monk_settings(:log_level) || :warn).to_s.upcase)
    $logger.datetime_format = "%Y-%m-%d %H:%M:%S"
    $logger
  end
end
