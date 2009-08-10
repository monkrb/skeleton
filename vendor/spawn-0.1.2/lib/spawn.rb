require "ostruct"

module Spawn
  def spawner &default
    @@spawn ||= Hash.new
    @@spawn[self] = default
  end

  def spawn attrs = {}
    @@spawn[self].call(model = OpenStruct.new(attrs))
    factory_method = respond_to?(:create!) ? :create! : :create
    send(factory_method, model.send(:table).merge(attrs))
  end
end
