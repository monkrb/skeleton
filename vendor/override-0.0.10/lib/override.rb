module Override
  def override object, methods
    methods.each do |method, result|
      result.respond_to?(:to_proc) ?
        object.meta_def(method, &result) :
        object.meta_def(method) { |*_| result }
    end
    object
  end

  def expect object, method, options
    expectation = lambda do |*params|
      unless params == options[:with]
        raise ExpectationError.new(options[:with], params)
      end
      options[:return]
    end
    override(object, method => expectation)
  end

  class ExpectationError < ArgumentError
    def initialize(expected, actual)
      super("Expected #{expected.inspect}, got #{actual.inspect}")
    end
  end
end

# Metaid == a few simple metaclass helper
# (See http://whytheluckystiff.net/articles/seeingMetaclassesClearly.html.)
class Object
  # The hidden singleton lurks behind everyone
  def metaclass; class << self; self; end; end
  def meta_eval &blk; metaclass.instance_eval &blk; end

  # Adds methods to a metaclass
  def meta_def name, &blk
    meta_eval { define_method name, &blk }
  end

  # Defines an instance method within a class
  def class_def name, &blk
    class_eval { define_method name, &blk }
  end
end
