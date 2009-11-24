require "rubygems"
require "sequel"
require "contest"
require File.dirname(__FILE__) + "/../lib/spawn"
require "faker"

DB = Sequel.sqlite
DB << "CREATE TABLE sequel_users (name VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL)"

class SequelUser < Sequel::Model
  extend Spawn

  def validate
    errors.add(:name, "Not present") if name.nil? or name.empty?
  end

  spawner do |user|
    user.email = Faker::Internet.email
  end
end

class TestSpawnWithSequel < Test::Unit::TestCase
  setup do
    @user = SequelUser.spawn :name => "John"
  end

  context "spawned user" do
    should "have John as name" do
      assert_equal "John", @user.name
    end

    context "with invalid attributes" do
      should "raise an error" do
        assert_raise Spawn::Invalid do
          SequelUser.spawn
        end
      end
    end
  end
end
