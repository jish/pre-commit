require 'minitest_helper'
require 'pre-commit/checks/tabs'

class TabsTest < MiniTest::Unit::TestCase

  def test_should_detect_a_tab
    check = Tabs.new
    check.staged_files = test_filename('tabs.rb')
    assert check.detected_bad_code?, 'should detect tabs'
  end

  def test_should_detect_leading_whitespace_followed_by_a_tab
    check = Tabs.new
    check.staged_files = test_filename('bad_tabs2.rb')
    assert check.detected_bad_code?, 'should detect leading whitespace followed by tabs'
  end

  def test_should_pass_a_valid_file
    check = Tabs.new
    check.staged_files = test_filename('valid_file.rb')
    assert !check.detected_bad_code?, 'should pass valid files'
  end

  def test_should_pass_a_binary_file_with_initial_tab
    check = Tabs.new
    check.staged_files = test_filename('property_sets-0.3.0.gem')
    assert check.run, 'A binary file with initial tab'
  end

  def test_error_message_should_contain_an_error_message_when_an_initial_tab_is_found
    check = Tabs.new
    def check.detected_bad_code?
      true
    end

    check.staged_files = test_filename('initial_tab.rb')
    assert !check.run, 'We should prevent an initial tab from being committed'

    assert_match(/pre-commit: detected tab before initial space:/, check.error_message)
    assert_match(/initial_tab.rb/, check.error_message)
  end

  def test_check_should_pass_if_staged_file_list_is_empty
    check = Tabs.new
    check.staged_files = []
    assert check.run
  end

end
