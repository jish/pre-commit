# encoding: utf-8
require 'minitest_helper'
require 'plugins/pre_commit/checks/coffeelint'

describe PreCommit::Checks::Coffeelint do
  let(:config) do
    mock = MiniTest::Mock.new
    mock.expect(:get, '', ['coffeelint.config'])
    mock
  end
  let(:check) {PreCommit::Checks::Coffeelint.new(nil, config, [])}

  it "succeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds for good code" do
    check.call([fixture_file('good.coffee')]).must_equal nil
  end

  it "fails for bad formatted code" do
    check.call([fixture_file("bad.coffee")]).must_equal <<-ERROR
  ✗ test/files/bad.coffee
     ✗ #1: Class names should be camel cased. class name: helloWorld.

✗ Lint! » 1 error and 0 warnings in 1 file

ERROR
  end
end unless `which coffeelint 2>/dev/null`.empty?
