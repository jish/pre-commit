require 'minitest_helper'
require 'pre-commit/checks/ruby_symbol_hashrockets'

class RubySymbolHashrocketsTest < MiniTest::Unit::TestCase

  def test_should_detect_a_symbol_hashrocket
    check = RubySymbolHashrockets.new
    check.staged_files = test_filename('wrong_hashrockets.rb')
    assert check.detected_bad_code?, 'should detect symbol hashrocket'
  end

  def test_should_not_detected_with_a_valid_file
    check = RubySymbolHashrockets.new
    check.staged_files = test_filename('valid_hashrockets.rb')
    assert !check.detected_bad_code?, 'should pass valid hashrocket'
  end

  def test_should_run_with_valid_file
    check = RubySymbolHashrockets.new
    check.staged_files = test_filename('valid_hashrockets.rb')
    assert check.run, 'should run valid hashrocket '
  end

  def test_check_should_pass_if_staged_file_list_is_empty
    check = RubySymbolHashrockets.new
    check.staged_files = []
    assert check.run
  end

  def test_guilty_file_in_error_messafe
    check = RubySymbolHashrockets.new
    check.staged_files = test_filename('wrong_hashrockets.rb')
    check.run
    assert_match(/hashrockets.rb/, check.error_message)
  end
end
