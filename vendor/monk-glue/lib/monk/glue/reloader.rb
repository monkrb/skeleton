require "rack/reloader"

# TODO Add documentation.
class Monk::Glue::Reloader < Rack::Reloader
  def initialize(app, cooldown = 0, backend = Stat)
    super(app, cooldown, backend)
  end

  def safe_load(file, mtime, stderr = $stderr)
    Main.reset!
    super(file, mtime, stderr)
  end
end
