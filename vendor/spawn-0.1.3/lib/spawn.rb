require "ostruct"

module Spawn

  Invalid = Class.new(ArgumentError)

  def spawner &default
    @@spawn ||= Hash.new
    @@spawn[self] = default
  end

  def spawn params = {}

    # Grab default parameters from spawner block.
    @@spawn[self].call(attrs = OpenStruct.new(params))

    # Initialize model
    model = new(attrs.send(:table).merge(params))

    # Yield model for changes to be made before saving.
    yield(model) if block_given?

    # Raise an error if the model is invalid or couldn't be saved.
    model.valid? and model.save and model or raise(Invalid, model.errors.inspect)
  end
end
