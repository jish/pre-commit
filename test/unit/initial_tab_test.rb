require 'minitest_helper'
require 'pre-commit/checks/initial_tab'

class InitialTabTest < MiniTest::Unit::TestCase

  def test_should_detect_an_intial_tab
    check = InitialTab.new
    check.staged_files = test_filename('initial_tab.rb')
    assert !check.run, 'We should prevent an initial tab from being committed'
  end

  def test_should_pass_a_file_with_no_initial_tab
    check = InitialTab.new
    check.staged_files = test_filename('valid_file.rb')
    assert check.run, 'A file with no initial tab'
  end

  def test_should_pass_a_binary_file_with_initial_tab
    check = InitialTab.new
    check.staged_files = test_filename('property_sets-0.3.0.gem')
    assert check.run, 'A binary file with initial tab'
  end

  def test_error_message_should_contain_an_error_message_when_an_initial_tab_is_found
    check = InitialTab.new
    check.staged_files = test_filename('initial_tab.rb')
    assert !check.run, 'We should prevent an initial tab from being committed'

    assert_match(/pre-commit: tab before initial space found:/, check.error_message)
    assert_match(/initial_tab.rb/, check.error_message)
  end

end
