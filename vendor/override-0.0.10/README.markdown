Override
============

The as-simple-as-possible-but-not-simpler stubbing library.

Description
-----------

Override is the essence of the stubbing concept: it takes an object,
a hash of methods/results, and proceeds to rewrite each method in the
object. It can be used as a stubbing strategy in most cases, and I'd
say that cases that don't fit this pattern have a very bad code smell,
because are either dealing with internals or with side effects.

Usage
-----

    require 'override'

    include Override

    user = User.spawn
    override(user, :name => "Foobar", :email => "foobar@example.org")
    override(User, :find => user)

Or alternatively:

    override(User, :find => override(User.spawn, :name => "Foobar, :email => "foobar@example.org"))

You can also send lambdas that will become the body of the redefined method:

    user = User.spawn :name => "Foobar"
    override(User, :find => lambda { |id| raise ArgumentError unless id == 1; user })

And then, in your tests:

    assert_raise ArgumentError do
      User.find(2)
    end

    assert_nothing_raised do
      User.find(1)
    end

    assert_equal "Foobar", User.find(1).name

In case you don't know what spawn means, check my library [Spawn](http://github.com/soveran/spawn).

It is a common pattern to set expectations for method calls. You can do
it with the `expect` function:

    user = User.spawn :name => "Foobar"
    expect(User, :find, :with => [:first, { :include => :friendships }], :return => user)

And then:

    assert_equal "Foobar", User.find(:first, :include => :friendships).name

This kind of tests encourage a very fine grained development
style. Testing side effects is possible with this and with many other
libraries, but it's something that should be avoided as much as
possible. Always keep in mind that a deterministic function is the
easiest to test, so the less coupling there is in the system, the more
reliable it becomes.

Note that this way of setting expectations doesn't count the number
of calls received by the redefined method. The RSpec equivalent of
`User.should_receive(:find).with(:first, :include => :friendships)`
triggers an exception if the method is not called. While it is a handy
feature, it encourages coupling and testing internals, so my advice
would be to use it scarcely and to try to refactor your code so it
doesn't follow this testing anti-pattern. Check the tests for more
examples.

Installation
------------

    $ sudo gem install override

Thanks
------

Thanks to Tim Goh for his advice of using a hash for rewriting multiple
methods at once.

License
-------

Copyright (c) 2009 Michel Martens

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
