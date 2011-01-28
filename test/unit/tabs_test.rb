require 'minitest_helper'
require 'pre-commit/checks/tabs'

class TabsTest < MiniTest::Unit::TestCase

  def test_should_detect_a_tab
    check = Tabs.new
    check.staged_files = test_filename('tabs.rb')
    assert check.detected_bad_code?, 'should detect tabs'
  end

  def test_should_pass_a_valid_file
    check = Tabs.new
    check.staged_files = test_filename('valid_file.rb')
    assert !check.detected_bad_code?, 'should pass valid files'
  end

end
