require File.dirname(__FILE__) + "/test_helper"
require File.dirname(__FILE__) + "/../rack_app"

class WebratRackTest < Test::Unit::TestCase
  def test_visits_pages
     visit "/"
     click_link "there"

     assert_have_tag("form[@method='post'][@action='/go']")
  end

  def test_submits_form
    visit "/go"
    fill_in "Name", :with => "World"
    fill_in "Email", :with => "world@example.org"
    click_button "Submit"

    assert_contain "Hello, World"
    assert_contain "Your email is: world@example.org"
  end

  def test_check_value_of_field
    visit "/"
    assert field_labeled("Prefilled").value, "text"
  end

  def test_follows_internal_redirects
    visit "/internal_redirect"
    assert response_body.include?("visit")
  end

  def test_does_not_follow_external_redirects
    visit "/external_redirect"
    assert last_response.redirect?
  end

  def test_last_request
    visit "/foo"
    assert_equal "/foo", last_request.env["PATH_INFO"]
  end
end
