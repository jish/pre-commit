require 'minitest_helper'
require 'pre-commit/checks/shell'

describe PreCommit::Checks::Shell do
  subject do
    PreCommit::Checks::Shell.new(nil, nil, [])
  end

  it "nil for success" do
    subject.send(:execute_raw, "true").must_be_nil
  end

  it "error for fail" do
    subject.send(:execute_raw, "echo test && false").must_equal "test\n"
  end

  it "nil for fail on expected false" do
    subject.send(:execute_raw, "echo test", success_status: false).must_equal "test\n"
  end

  it "nil for fail on expected false" do
    subject.send(:execute_raw, "false", success_status: false).must_be_nil
  end

  it "builds_command" do
    subject.send(:build_command, ["echo", "test more"]).must_equal "echo test\\ more"
  end

  it "does not escape speciall shell things" do
    subject.send(:build_command, ["grep", "|", "grep"]).must_equal "grep | grep"
  end

end
