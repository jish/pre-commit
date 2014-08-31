# encoding: utf-8

require 'minitest_helper'
require 'plugins/pre_commit/checks/reek'

describe PreCommit::Checks::Reek do
  let(:config) do
    mock = MiniTest::Mock.new
    mock.expect(:get, '', ['reek.config'])
    mock
  end

  let(:check) { PreCommit::Checks::Reek.new(nil, config, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([fixture_file('valid_file.rb')]).must_equal nil
  end

  it "fails if file is smelly" do
    check.call([fixture_file('smelly_file.rb')]).must_match(/1 warning/)
  end
end
