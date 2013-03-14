require 'minitest_helper'
require 'pre-commit/checks/rspec_focus_check'

class RSpecFocusCheckTest < MiniTest::Unit::TestCase

  def test_should_detect_a_focus_symbol
    check = PreCommit::RSpecFocusCheck.new
    check.grep_command = "grep"
    check.staged_files = test_filename('bad_spec.rb')
    assert !check.instances_of_rspec_focus_violations.empty?
  end

  def test_should_pass_a_file_with_no_focus_symbol
    check = PreCommit::RSpecFocusCheck.new
    check.grep_command = "grep"
    check.staged_files = test_filename('good_spec.rb')
    assert check.instances_of_rspec_focus_violations.empty?
  end

  def test_error_message_should_contain_an_error_message_when_a_focus_symbol_is_found
    check = PreCommit::RSpecFocusCheck.new
    def check.detected_bad_code?; true; end
    check.grep_command = "grep"
    check.staged_files = test_filename('bad_spec.rb')
    check.run

    assert_match(/pre-commit: :focus in spec\(s\) found:/, check.error_message)
    assert_match(/bad_spec.rb/, check.error_message)
  end

end
