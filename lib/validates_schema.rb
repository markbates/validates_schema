require 'active_record'

Dir.glob(File.join(File.dirname(__FILE__), 'validates_schema', '**/*.rb')).each do |f|
  require File.expand_path(f)
end
