require File.dirname(__FILE__) + '/../lib/spawn'

ActiveRecord::Base.send(:extend, Spawn)
