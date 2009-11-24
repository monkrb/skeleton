require "rubygems"
require "active_record"
require "contest"
require File.dirname(__FILE__) + "/../lib/spawn"
require "faker"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile  => ":memory:")
ActiveRecord::Schema.define do
  create_table :active_record_users do |table|
      table.column :name, :string
      table.column :email, :string
  end
end

class ActiveRecordUser < ActiveRecord::Base
  extend Spawn

  validates_presence_of :name

  spawner do |user|
    user.email = Faker::Internet.email
  end
end

class TestSpawnWithActiveRecord < Test::Unit::TestCase
  context "spawned user" do
    setup do
      @user = ActiveRecordUser.spawn :name => "John"
    end

    should "have John as name" do
      assert_equal "John", @user.name
    end

    context "with invalid attributes" do
      should "raise an error" do
        assert_raise Spawn::Invalid do
          ActiveRecordUser.spawn
        end
      end
    end
  end
end
