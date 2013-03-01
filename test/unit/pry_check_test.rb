require 'minitest_helper'
require 'pre-commit/checks/pry_check'

class PryCheckTest < MiniTest::Unit::TestCase

  def test_should_detect_a_binding_pry_statement
    check = PreCommit::PryCheck.new
    check.grep_command = "grep"
    check.staged_files = test_filename('pry_file.rb')
    assert !check.instances_of_pry_violations.empty?
  end

  def test_should_pass_a_file_with_no_binding_pry_statement
    check = PreCommit::PryCheck.new
    check.grep_command = "grep"
    check.staged_files = test_filename('valid_file.rb')
    assert check.instances_of_pry_violations.empty?
  end

  def test_error_message_should_contain_an_error_message_when_a_binding_pry_statement_is_found
    check = PreCommit::PryCheck.new
    def check.detected_bad_code?; true; end
    check.grep_command = "grep"
    check.staged_files = test_filename('pry_file.rb')
    check.run

    assert_match(/pre-commit: binding.pry statement\(s\) found:/, check.error_message)
    assert_match(/pry_file.rb/, check.error_message)
  end

end
