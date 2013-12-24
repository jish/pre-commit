require 'minitest_helper'
require 'plugins/pre_commit/checks/rspec_focus'

describe PreCommit::Checks::RspecFocus do
  let(:check){ PreCommit::Checks::RspecFocus }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds on non-specs" do
    check.call([test_filename('bad-spec.rb')]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([test_filename('good_spec.rb')]).must_equal nil
  end

  it "fails if file contains pry" do
    check.call([test_filename('bad_spec.rb')]).must_equal ":focus found in specs:\ntest/files/bad_spec.rb:2:  context \"functionality\", :focus do"
  end
end
