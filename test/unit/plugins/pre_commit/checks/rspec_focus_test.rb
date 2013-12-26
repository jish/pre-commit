require 'minitest_helper'
require 'plugins/pre_commit/checks/rspec_focus'

describe PreCommit::Checks::RspecFocus do
  let(:check){ PreCommit::Checks::RspecFocus.new(nil, nil) }

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
    check.call([test_filename('bad_spec.rb')]).must_equal(<<-EXPECTED)
:focus found in specs:
test/files/bad_spec.rb:2:  context \"functionality\", :focus do
EXPECTED
  end
end
