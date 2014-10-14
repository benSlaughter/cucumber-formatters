require 'rubygems'
require 'rspec/core/rake_task'
require 'yard'

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  ENV['CODECLIMATE_REPO_TOKEN'] = 'd26edb3733ab0dd98fc56f5b7e6b5182222fb87b8eb6f4dc2c4628906b5c5692'
  t.rspec_opts = %w[--color]
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  #t.options = ['--any', '--extra', '--opts'] # optional
  #t.options = ['--list-undoc'] # optional
end

task :default => [:spec]