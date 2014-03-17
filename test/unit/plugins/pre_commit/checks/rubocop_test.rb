require 'minitest_helper'
require 'plugins/pre_commit/checks/rubocop'

describe PreCommit::Checks::Rubocop do
  let(:config) do
    mock = MiniTest::Mock.new
    mock.expect(:get, '', ['rubocop.config'])
    mock
  end

  let(:check){ PreCommit::Checks::Rubocop.new(nil, config, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([fixture_file('valid_file.rb')]).must_equal nil
  end

  it "fails if file contains errors" do
    # rubinius finds only 1 offense, all others find 2
    check.call([fixture_file('merge_conflict.rb')]).must_match(/1 file inspected, (\e\[31m)?[12] offenses? detected/)
  end
end
