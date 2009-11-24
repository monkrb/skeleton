require "rubygems"
require "ohm"
require "contest"
require File.dirname(__FILE__) + "/../lib/spawn"

Ohm.connect

class OhmUser < Ohm::Model
  extend Spawn

  attribute :name
  attribute :email

  def validate
    assert_present :name
  end

  spawner do |user|
    user.email = "albert@example.com"
  end
end

class TestSpawnWithOhm < Test::Unit::TestCase
  setup do
    @user = OhmUser.spawn :name => "John"
  end

  context "spawned user" do
    should "have John as name" do
      assert_equal "John", @user.name
    end

    context "with invalid attributes" do
      should "raise an error" do
        assert_raise Spawn::Invalid do
          OhmUser.spawn
        end
      end
    end
  end
end
