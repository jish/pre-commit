require 'minitest_helper'
require 'pre-commit/checks/ruby_symbol_hashrockets'

class RubySymbolHashrocketsTest < MiniTest::Unit::TestCase

  def test_should_detect_a_symbol_hashrocket
    check = PreCommit::RubySymbolHashrockets.new
    check.staged_files = test_filename('wrong_hashrockets.rb')
    assert check.detected_bad_code?, 'should detect symbol hashrocket'
  end

  def test_should_detect_all_symbol_hashrockets
    check = PreCommit::RubySymbolHashrockets.new
    check.staged_files = test_filename('wrong_hashrockets.rb')
    assert_equal 8, check.violations[:lines].split("\n").size
  end

  def test_does_not_detect_bad_code_in_a_valid_file
    check = PreCommit::RubySymbolHashrockets.new
    check.staged_files = test_filename('valid_hashrockets.rb')
    assert !check.detected_bad_code?, 'should pass valid hashrocket'
  end

  def test_should_run_with_valid_file
    check = PreCommit::RubySymbolHashrockets.new
    check.staged_files = test_filename('valid_hashrockets.rb')
    assert check.run, 'should run valid hashrocket '
  end

  def test_check_should_pass_if_staged_file_list_is_empty
    check = PreCommit::RubySymbolHashrockets.new
    check.staged_files = []
    assert check.run
  end

  def test_guilty_file_in_error_message
    check = PreCommit::RubySymbolHashrockets.new
    check.staged_files = test_filename('wrong_hashrockets.rb')
    check.run
    assert_match(/wrong_hashrockets.rb/, check.error_message)
  end
end
