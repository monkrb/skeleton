require "test_helper"

class CssTest < Test::Unit::TestCase
  test "renders the default stylesheet" do
    get "/css/main.css"
    assert_equal "text/css;charset=UTF-8", last_response.content_type
  end
end
