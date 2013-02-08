require "rake/testtask"

Rake::TestTask.new do |test|
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :ci => [:test]
task :default => [:test]

namespace :pre_commit do
  desc "run the tests"
  task :ci => [:test]
end
