require File.dirname(__FILE__) + "/../lib/stories"
require File.dirname(__FILE__) + "/../lib/stories/runner"
require File.dirname(__FILE__) + "/../lib/stories/runner/pdf"

class Stories::Runner::PDF
  def render_header(pdf)
    pdf.text "My custom header", :size => 20, :style => :bold
    pdf.move_down 20
  end
end

# Use the story runner by default.
Test::Unit::AutoRunner::RUNNERS[:console] = Proc.new {|r| Stories::Runner::PDF }

class UserStoryTest < Test::Unit::TestCase
  story "As a user I want to create stories with a custom PDF" do
    setup do
      @user = "valid user"
    end

    scenario "A valid user" do
      assert_equal "valid user", @user
    end
  end
end
