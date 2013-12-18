require 'minitest_helper'
require 'plugins/pre-commit/checks/debugger_check'

describe PreCommit::DebuggerCheck do
  let(:check){ PreCommit::DebuggerCheck }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([test_filename('valid_file.rb')]).must_equal nil
  end

  it "fails if file contains debugger" do
    check.call([test_filename('debugger_file.rb')]).must_equal "debugger statement(s) found:\ntest/files/debugger_file.rb:3:    debugger"
  end

  it "Skips checking the Gemfile" do
    files = [test_filename("with_debugger/Gemfile")]
    check.call(files).must_equal nil
  end

  it "Skips checking the Gemfile.lock" do
    files = [test_filename("with_debugger/Gemfile.lock")]
    check.call(files).must_equal nil
  end
end
