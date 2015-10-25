# Load the Rails application.
require File.expand_path('../application', __FILE__)

begin
  klass = Module.const_get("Active::Resource")
  puts klass
  klass.is_a?(Class)
rescue NameError
  puts "Active::Resource does not exist!"
end

# Initialize the Rails application.
Rails.application.initialize!
