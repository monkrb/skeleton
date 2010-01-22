class Monk::Glue::Reloader
  def initialize(app, app_class = Main)
    @app = app
    @app_class = app_class
    @last = last_mtime
  end

  def call(env)
    current = last_mtime

    if current > @last
      if Thread.list.size > 1
        Thread.exclusive { reload! }
      else
        reload!
      end

      @last = current
    end

    @app.call(env)
  end

  def reload!
    files.each do |file|
      $LOADED_FEATURES.delete(file)
    end

    @app_class.reset!

    require File.expand_path(@app_class.app_file)
  end

  # Returns the timestamp for the most recently modified app file.
  def last_mtime
    files.map do |file|
      ::File.stat(file).mtime
    end.max
  end

  # Returns the list of application files.
  def files
    Dir[root_path("app", "**", "*.rb")] + [@app_class.app_file]
  end
end
