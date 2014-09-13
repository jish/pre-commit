require 'minitest_helper'
require 'pre-commit/checks/shell'

describe PreCommit::Checks::Shell do
  subject do
    PreCommit::Checks::Shell.new(nil, nil, [])
  end

  it "nil for success" do
    subject.send(:execute, "true").must_equal nil
  end

  it "error for fail" do
    subject.send(:execute, "echo test && false").must_equal "test\n"
  end

  it "nil for fail on expected false" do
    subject.send(:execute, "echo test && true", success_status: false).must_equal "test\n"
  end

  it "nil for fail on expected false" do
    subject.send(:execute, "false", success_status: false).must_equal nil
  end

end
