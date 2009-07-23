require "rack/reloader"

# TODO Add documentation.
class Monk::Glue::Reloader < Rack::Reloader
  def safe_load(file, mtime, stderr = $stderr)
    super
    Main.reset!
    super(Main.app_file, mtime, stderr)
  end
end
