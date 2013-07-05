require 'minitest_helper'
require 'pre-commit/checks/debugger_check'

describe PreCommit::DebuggerCheck do
  let(:check){ PreCommit::DebuggerCheck }

  it "succeeds if nothing changed" do
    check.run([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.run([test_filename('valid_file.rb')]).must_equal nil
  end

  it "fails if file contains debugger" do
    check.run([test_filename('debugger_file.rb')]).must_equal "debugger statement(s) found:\ntest/files/debugger_file.rb:3:    debugger"
  end
end
