require "rack/reloader"

# TODO Add documentation.
class Monk::Glue::Reloader < Rack::Reloader
  def initialize(app, cooldown = 0, backend = Stat)
    super(app, cooldown, backend)
  end

  def safe_load(file, mtime, stderr = $stderr)
    $LOADED_FEATURES.delete_if {|path| path =~ /^#{root_path}/ }
    Main.reset!
    super(Main.app_file, mtime, stderr)
  end
end
