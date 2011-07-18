
desc 'Run tests'
task :test do
  result = system("ruby -Ilib -Itest -e 'ARGV.each { |f| load f }' test/unit/*")
  exit(result ? 0 : 1)
end

task :ci => [:test]
task :default => [:test]

namespace :pre_commit do
  desc "run the tests"
  task :ci => [:test]
end
