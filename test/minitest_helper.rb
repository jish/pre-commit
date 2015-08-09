if
  RUBY_VERSION == "2.0.0" # check Gemfile
then
  require "coveralls"
  require "simplecov"

  SimpleCov.start do
    formatter SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter,
    ]
    command_name "Spesc Tests"
    add_filter "/test/"
    #add_filter "/demo/"
  end

  Coveralls.noisy = true unless ENV['CI']
end

require 'minitest/autorun'
require "minitest/reporters"
require 'tmpdir'
require 'pluginator'

Minitest::Reporters.use!

module PreCommit; module Helpers

  def fixture_file(filename)
    file_dir = File.expand_path('../files', __FILE__).sub("#{project_dir}/", "")
    File.join(file_dir, filename)
  end

  def write(file, content)
    File.open(file, "w") { |f| f.write content }
  end

  def create_temp_dir
    @dir = Dir.mktmpdir(nil, ENV['TMPDIR'] || '/tmp')
    @old_dir = Dir.pwd
    Dir.chdir(@dir)
  end

  def destroy_temp_dir
    Dir.chdir(@old_dir)
    FileUtils.rm_rf(@dir)
  end

  def in_tmpdir
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        yield
      end
    end
  end

  def ruby_includes
    "-I #{Gem::Specification.find_by_name('pluginator').full_gem_path}/lib -I #{project_dir}/lib"
  end

  def start_git
    sh "git init"
  end

  def project_dir
    File.expand_path("../../", __FILE__)
  end

  def sh(command, options={})
    result = `#{command} 2>&1`
    raise "FAILED #{command}\n#{result}" if $?.success? == !!options[:fail]
    result
  end

end; end

module PreCommit
  module PrintTestNames
    def after_teardown
      super
      if !passed?
        puts "Test #{@__name__} did not pass."
      end
    end
  end
end

class MiniTest::Test
  include PreCommit::Helpers
end

class MiniTest::Unit::TestCase
  include PreCommit::Helpers
  include PreCommit::PrintTestNames
end
