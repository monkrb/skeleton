Stories
=======

Stories and User Acceptance Tests for the minimalist test framework [Contest](http://github.com/citrusbyte/contest).

Description
-----------

Write user stories and user acceptace tests using Contest, the tiny add on to Test::Unit that provides nested contexts and declarative tests.

Usage
-----

Declare your stories as follows:

    require 'stories'

    class UserStoryTest < Test::Unit::TestCase
      story "As a user I want to create stories so I can test if they pass" do
        setup do
          @user = "valid user"
        end

        scenario "A valid user" do
          assert_equal "valid user", @user
        end
      end
    end

If you are using Rails, you can use stories for your integration tests with Webrat:

    class UserStoriesTest < ActionController::IntegrationTest
      story "As a user I want to log in so that I can access restricted features" do
        setup do
          @user = User.spawn :name => "Albert", :email => "albert@example.com"
        end

        scenario "Using good information" do
          visit "/"
          click_link "Log in"
          fill_in "Email", :with => user.email
          fill_in "Password", :with => user.password
          click_button "Sign in"

          assert_contain "Logout"
          assert_contain "Welcome Albert"
        end
      end
    end

This will produce the following output:

    - As a user I want to lo in so that I can access restricted features
        Using good information
            Go to “/”
            Click “Log in”
            Fill in “Email” with “albert@example.com”
            Fill in “Password” with “secret”
            Click “Sign in”
            I should see “Logout”
            I should see “Welcome Albert”

Custom reports
--------------

Stories ships with reports for many Webrat helpers, but you can write your own version or add reports
for other helpers.

For instance, let's say you add this assertion:

    module Test::Unit::Assertions
      def assert_current_page(path)
        assert_equal path, current_url.sub(%r{^http://www\.example\.com}, '')
      end
    end

When you run it, no output will be generated because Stories doesn't know what to say about this assertion.
Adding a custom report is easy:

    module Stories::Webrat
      report_for :assert_current_page do |page|
        "I should be on #{quote(page)}"
      end
    end

All this should reside in your `stories_helper.rb`.

Step wrappers
---------------

There are two other methods that are useful for reporting steps or assertions: `silent` and `report`.

The `silent` helper gives you the ability to suspend the steps and assertions' normal output:

    ...
    silent do
      assert_contain "Some obscure hash"
    end
    ...

In a similar fashion, `report` lets you replace the normal output with your own message:

    ...
    report "I verify that the hash generated correctly" do
      assert_contain "The same obscure hash"
    end
    ...

Running stories
---------------

You can run it normally, it's Test::Unit after all. If you want to run a particular test, say "yet more tests", try this:

    $ ruby my_test.rb -n test_yet_more_tests

Or with a regular expression:

    $ ruby my_test.rb -n /yet_more_tests/

Pending stories
---------------

Since Stories aims to improve your project's documentation, you can have pending stories:

    class UserStoryTest < Test::Unit::TestCase
      story "As a user I want to create stories so I can test if they pass"
    end

This is useful if you want to write all your stories upfront, even before you write the acceptance tests.

Awesome output
--------------

You can get a nice output with your user stories with the `stories` runner:

    $ ruby my_test.rb --runner=stories

Now, if you want to impress everyone around you, try this:

    $ ruby my_test.rb --runner=stories-pdf

You will get a nicely formatted PDF with your user stories. It uses [Prawn](http://prawn.majesticseacreature.com/), so you will need to install it first.

If you're using Rails, you can run the whole build with the following Rake tasks:

    $ rake stories
    $ rake stories:pdf

Installation
------------

    $ sudo gem install stories

If you want to use it with Rails, add this to config/environment.rb:

    config.gem "stories"

Then you can vendor the gem:

    rake gems:install
    rake gems:unpack

License
-------

Copyright (c) 2009 Damian Janowski and Michel Martens for Citrusbyte

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
