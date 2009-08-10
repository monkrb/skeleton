require File.dirname(__FILE__) + "/../lib/stories"
require File.dirname(__FILE__) + "/../lib/stories/runner"

# Use the story runner by default.
Test::Unit::AutoRunner::RUNNERS[:console] = Proc.new {|r| Stories::Runner }

class UserStoryTest < Test::Unit::TestCase
  story "As a user I want to create stories so I can test if they pass" do
    setup do
      @user = "valid user"
    end

    scenario "A valid user" do
      assert_equal "valid user", @user
    end
  end

  story "As a user I want helpers so that I can extract" do
    def some_helper
      1
    end

    scenario "A call to a helper" do
      report "I use some helper" do
        some_helper
      end
      assert_equal 1, some_helper
    end
  end

  story "Pending story"
end
