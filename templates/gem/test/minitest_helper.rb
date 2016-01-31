=begin
Copyright <%= copyright %>

See the file LICENSE for copying permission.
=end

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
  end

  Coveralls.noisy = true unless ENV['CI']
end

require 'minitest/autorun'
require "minitest/reporters"
require "mocha/setup"
require 'pluginator'

module PreCommit; module Helpers

  def test_files
    File.expand_path("../files", __FILE__)
  end

end; end

class MiniTest::Unit::TestCase
  include PreCommit::Helpers
end

Dir['lib/**/*.rb'].each { |file| require "./#{file}" } # coverals trick for all files

Minitest::Reporters.use!
