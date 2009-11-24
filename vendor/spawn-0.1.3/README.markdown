Spawn
=======

A ridiculously simple fixtures replacement for your web framework of
choice.

Description
-----------

Spawn is a very small library that can effectively replace fixtures or
any other huge library for the same task.

Usage
-----

In the examples below we are using [Faker](http://faker.rubyforge.org/)
to generate random data, but you can use any method.

With [ActiveRecord](http://api.rubyonrails.org/classes/ActiveRecord/Base.html):

    class User < ActiveRecord::Base
      spawner do |user|
        user.name = Faker::Name.name
        user.email = Faker::Internet.email
      end
    end

With [Sequel](http://sequel.rubyforge.org/):

    class User < Sequel::Model
      extend Spawn

      spawner do |user|
        user.name = Faker::Name.name
        user.email = Faker::Internet.email
      end
    end

With [Ohm](http://ohm.keyvalue.org):

    class User < Ohm::Model
      extend Spawn

      attribute :name
      attribute :email

      spawner do |user|
        user.name = Faker::Name.name
        user.email = Faker::Internet.email
      end
    end

If you don't want to pollute your class definition, you
can of course use it from outside:

    User.spawner do |user|
      user.name = Faker::Name.name
      user.email = Faker::Internet.email
    end

Then, in your test or in any other place:

    @user = User.spawn

Or, if you need something special:

    @user = User.spawn :name => "Michel Martens"

This sends to User.new all the attributes defined in the spawner block, along with
the hash of attributes passed when spawning.

If you want a reference to the model before the validity is checked, you can pass
a block:

    @user = User.spawn { |u| u.name = "Michel Martens" }


Conditional evaluation
----------------------

Spawn will execute the right hand side of your assignment even if you
provide a value for some particular key. Consider the following example:

    User.spawner do |user|
      user.profile = Profile.spawn # Profile.spawn is executed even if you provide a value for :profile.
    end

    User.spawn(:profile => Profile.first)

Here, you will be creating an extra instance of `Profile`, because when
the block is evaluated it calls `Profile.spawn`. If the right hand side
of your assignment is costly or has side effects, you may want to avoid
this behavior by using `||=`:

    User.spawner do |user|
      user.profile ||= Profile.spawn
    end

Then, if you pass a `:profile`:

    User.spawn(:profile => Profile.first)

You can verify that `Profile.spawn` is never called. Although this
may sound evident, it can bite you if you rely on the RHS not executing
(e.g. if you're using Spawn to populate fake data into a database and
you want to control how many instances you create).

Installation
------------

    $ sudo gem install spawn

### Thanks

Thanks to [Foca](http://github.com/foca) for his suggestions and
[Pedro](http://github.com/peterpunk) for the original gemspec.

License
-------

Copyright (c) 2009 Michel Martens and Damian Janowski

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
