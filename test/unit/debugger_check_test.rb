require 'minitest_helper'
require 'pre-commit/checks/debugger_check'

class DebuggerCheckTest < MiniTest::Unit::TestCase

  def test_should_detect_a_debugger_statement
    check = DebuggerCheck.new
    check.grep_command = "grep"
    check.staged_files = test_filename('debugger_file.rb')
    assert !check.run, 'We should prevent a debugger statement from being committed'
  end

  def test_should_pass_a_file_with_no_debugger_statement
    check = DebuggerCheck.new
    check.grep_command = "grep"
    check.staged_files = test_filename('valid_file.rb')
    assert check.run, 'A file with no debugger statement'
  end

  def test_error_message_should_contain_an_error_message_when_a_debugger_statement_is_found
    check = DebuggerCheck.new
    check.grep_command = "grep"
    check.staged_files = test_filename('debugger_file.rb')
    assert !check.run, 'We should prevent a debugger statement from being committed'

    assert_match(/pre-commit: debugger statement found:/, check.error_message)
    assert_match(/debugger_file.rb/, check.error_message)
  end

end
