require 'minitest_helper'
require 'pre-commit/checks/debugger_check'

class DebuggerCheckTest < MiniTest::Unit::TestCase

  def test_should_detect_a_debugger_statement
    check = PreCommit::DebuggerCheck.new
    check.grep_command = "grep"
    check.staged_files = test_filename('debugger_file.rb')
    assert !check.instances_of_debugger_violations.empty?
  end

  def test_should_pass_a_file_with_no_debugger_statement
    check = PreCommit::DebuggerCheck.new
    check.grep_command = "grep"
    check.staged_files = test_filename('valid_file.rb')
    assert check.instances_of_debugger_violations.empty?
  end

  def test_error_message_should_contain_an_error_message_when_a_debugger_statement_is_found
    check = PreCommit::DebuggerCheck.new
    def check.detected_bad_code?; true; end
    check.grep_command = "grep"
    check.staged_files = test_filename('debugger_file.rb')
    check.run

    assert_match(/pre-commit: debugger statement\(s\) found:/, check.error_message)
    assert_match(/debugger_file.rb/, check.error_message)
  end

end
