require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new do |test|
  test.libs << "test" << "lib"
  test.pattern = "test/**/*_test.rb"
  test.verbose = true
end

task :ci => [:test]
task :default => [:test]

namespace :pre_commit do
  desc "run the tests"
  task :ci => [:test]
end

RDoc::Task.new do |task|
  task.main = 'Readme.md'
  task.rdoc_files.include('Readme.md', 'lib/**/*.rb')
  task.rdoc_dir = 'rdoc/html'
end
