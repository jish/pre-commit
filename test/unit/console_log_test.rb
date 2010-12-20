require 'minitest_helper'
require 'pre-commit/checks/console_log'

class ConsoleLogTest < MiniTest::Unit::TestCase

  # TODO silence the output of this test
  def test_should_detect_an_extraneous_console_log_statement
    check = ConsoleLog.new
    check.staged_files = test_filename('console_log.js')
    assert !check.run, 'We should prevent a `console.log` from being committed'
  end

  def test_should_pass_a_file_with_no_extraneous_console_log_statements
    check = ConsoleLog.new
    check.staged_files = test_filename('valid_file.js')
    assert check.run, 'A file with no `console.log` statements should pass'
  end

end
