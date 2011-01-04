require 'rubygems'
require 'rspec'
require 'logger'

FileUtils.mkdir_p(File.join(File.dirname(__FILE__), 'tmp'))
RAILS_DEFAULT_LOGGER = Logger.new(File.join(File.dirname(__FILE__), 'tmp', 'dj.log'))

require File.join(File.dirname(__FILE__), 'database.rb')

require File.join(File.dirname(__FILE__), '..', 'lib', 'validates_schema')

class User < ActiveRecord::Base
end

class People < ActiveRecord::Base
  set_table_name :users
end

class Picasso < ActiveRecord::Base
  self.abstract_class = true
end

class Artist < Picasso
end

Rspec.configure do |config|
  
  config.before(:all) do
    
  end
  
  config.after(:all) do
    
  end
  
  config.before(:each) do
    
  end
  
  config.after(:each) do
    
  end
  
end
