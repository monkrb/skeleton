require 'rubygems'
require 'contest'
require File.dirname(__FILE__) + "/../lib/spawn"

class Base
  attr_accessor :attributes

  def initialize(attrs = {})
    @attributes = attrs
  end

  def self.create(attrs = {})
    new(attrs)
  end

  def bar; attributes[:bar] end
  def baz; attributes[:baz] end

  def bar=(value); attributes[:bar] = value; end
  def baz=(value); attributes[:baz] = value; end

  def save
    self
  end

  def valid?
    true
  end

  extend Spawn
end

class Foo < Base
  class << self
    alias_method :create!, :create
  end

  spawner do |object|
    object.bar = 7
    object.baz = 8
  end
end

class Bar < Foo
  spawner do |bar|
    bar.bar = 9
    bar.baz = 10
  end
end

class Baz < Base
  spawner do |object|
    object.bar = 7
    object.baz = 8
  end
end

module FooBar
  class Baz < ::Base
    spawner do |baz|
      baz.bar = 1
    end
  end
end

module FooBaz
  class Baz < ::Base
    spawner do |baz|
      baz.bar = 2
    end
  end
end

class Qux < Base
  def self.name; "Qux"; end

  spawner do |barz|
    barz.bar ||= raise "Should have received :bar"
  end
end

class TestFoo < Test::Unit::TestCase
  should "have a name class method" do
    assert Foo.respond_to?(:name)
    assert_equal "Foo", Foo.name
  end

  context "with attributes :bar and :baz" do
    context "when sent a hash on initialization" do
      should "set the attributes to the passed values" do
        foo = Foo.new :bar => 1, :baz => 2
        assert_equal 1, foo.bar
        assert_equal 2, foo.baz
      end

      should "pass the values to the block" do
        assert_raise(RuntimeError) do
          Qux.spawn
        end

        assert_equal "Qux", Qux.spawn(:bar => "Qux").bar
      end
    end
  end

  context "that implements Spawn" do
    should "be kind of Spawn" do
      assert Foo.kind_of?(Spawn)
    end

    context "when instantiated with spawn" do
      context "without parameters" do
        should "initialize the instance with the defined block" do
          foo = Foo.spawn
          assert_equal 7, foo.bar
          assert_equal 8, foo.baz
        end
      end

      context "with a hash supplied" do
        should "override the default values" do
          foo = Foo.spawn :bar => 1
          assert_equal 1, foo.bar
          assert_equal 8, foo.baz
        end
      end

      context "with a block supplied" do
        should "override the default values with single assignments" do
          foo = Foo.spawn(:bar => 1) do |f|
            f.baz = 2
          end
          assert_equal 1, foo.bar
          assert_equal 2, foo.baz
        end
      end

      context "and a class Bar" do
        context "that also implements Spawn" do
          should "be kind of Spawn" do
            assert Bar.kind_of?(Spawn)
          end

          context "when sent :name" do
            should "return 'Bar'" do
              assert_equal "Bar", Bar.name
            end
          end

          context "when sent :spawn" do
            should "return an instance of Bar" do
              assert Bar.spawn.kind_of?(Bar)
            end

            should "not interfere with Foo.spawn" do
              assert_equal 7, Foo.spawn.bar
              assert_equal 9, Bar.spawn.bar
            end
          end
        end
      end
    end

    context "and it doesn't understand #create! (only #create)" do
      should "work anyway" do
        baz = Baz.spawn :bar => 1
        assert_equal 1, baz.bar
      end
    end
  end

  should "respect namespaces" do
    assert_equal 1, FooBar::Baz.spawn.bar
    assert_equal 2, FooBaz::Baz.spawn.bar
  end
end
