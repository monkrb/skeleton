Dependencies
============

Dependencies manager for RACK enabled applications.

Description
-----------

Dependencies allows you to declare the list of libraries your application needs,
even specifying the version and environment it will be required in, and all with
the simple sintax we all have grown to know. It comes with a handy command line
tool for inspecting your dependencies.

Usage
-----

Declare your dependencies in a `dependencies` in the root of your project.
This file will look like this:

    rack ~> 1.0
    sinatra
    webrat (test) git://github.com/brynary/webrat.git
    quietbacktrace ~> 0.1
    contest ~> 0.1 (test)
    haml ~> 2.0
    rack-test 0.3 (test)
    faker ~> 0.3
    spawn ~> 0.1
    ohm git://github.com/soveran/ohm.git

Now you can try the `dep` command line tool to check your dependencies:

    $ dep list

You can even specify an environment to see if requirements are met:

    $ dep list test

The list can contain not only gems, but libraries in `vendor` too. Dependencies
first checks if a matching library in vendor exists, then tries to find a
suitable gem.

In order to use it in your project, just require the `dependencies` gem.

Installation
------------

    $ sudo gem install dependencies

License
-------

Copyright (c) 2009 Damian Janowski

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
