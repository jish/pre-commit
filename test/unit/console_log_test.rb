require File.expand_path('../../minitest_helper', __FILE__)
require 'pre-commit/checks/console_log'

class ConsoleLogTest < MiniTest::Unit::TestCase

  def test_should_detect_an_extraneous_console_log_statement
    check = PreCommit::ConsoleLog.new
    check.staged_files = test_filename('console_log.js')
    assert !check.run, 'We should prevent a `console.log` from being committed'
  end

  def test_should_pass_a_file_with_no_extraneous_console_log_statements
    check = PreCommit::ConsoleLog.new
    check.staged_files = test_filename('valid_file.js')
    assert check.run, 'A file with no `console.log` statements should pass'
  end

  def test_should_pass_a_non_js_file_with_console_log_statements
    check = PreCommit::ConsoleLog.new
    check.staged_files = test_filename('changelog.md')
    assert check.run, 'A non-JS file with `console.log` statements should pass'
  end

  def test_error_message_should_contain_an_error_message_when_console_log_is_found
    check = PreCommit::ConsoleLog.new
    check.staged_files = test_filename('console_log.js')
    assert !check.run, 'We should prevent a `console.log` from being committed'

    assert_match(/pre-commit: console.log found:/, check.error_message)
    assert_match(/console_log.js/, check.error_message)
    assert_match(/console.log/, check.error_message)
  end

end
