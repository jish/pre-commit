require 'minitest_helper'
require 'plugins/pluginator/extensions/find_check'
require 'plugins/pre_commit/checks/before_all'

class FirstAskTester
  attr_accessor :plugins
  include Pluginator::Extensions::FindCheck
end

describe Pluginator::Extensions::FindCheck do
  before do
    @tester = FirstAskTester.new
    @tester.plugins = { "checks" => [PreCommit::Checks::BeforeAll] }
    $stderr = StringIO.new
  end
  after do
    $stderr = STDERR
  end

  it "finds existing plugin" do
    @tester.find_check("before_all").must_equal( PreCommit::Checks::BeforeAll )
    $stderr.string.must_equal("")
  end

  it "does not find missing plugin" do
    @tester.find_check("missing_plugin").must_be_nil
    $stderr.string.must_equal(<<-EXPECTED)
Could not find plugin supporting missing_plugin / MissingPlugin,
available plugins: BeforeAll
EXPECTED
  end

end
