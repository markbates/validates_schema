require 'rubygems'

# Set up gems listed in the Gemfile.
gemfile = File.expand_path('../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

Bundler.require

Gemstub.test_framework = :rspec

Gemstub.gem_spec do |s|
  s.version = '1.0.0'
  s.rubyforge_project = 'validates_schema'
  s.add_dependency('activerecord', '>= 3.0.0')
  s.email = 'mark@markbates.com'
  s.homepage = 'http://www.metabates.com'
end

Gemstub.rdoc do |rd|
  rd.title = 'validates_schema'
end
