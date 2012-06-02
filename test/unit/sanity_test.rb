require 'minitest_helper'
require 'pre-commit/checks/sanity'

class SanityTest < MiniTest::Unit::TestCase

  def test_should_detect_bad_character
    %w(1 2).each do |number|
      check = Sanity.new
      check.staged_files = test_filename("bad_file_#{number}.css")
      assert check.detected_bad_code?, 'should detect bad character'
    end
  end

  def test_should_pass_a_valid_file
    check = Sanity.new
    check.staged_files = test_filename('valid_file.rb')
    assert !check.detected_bad_code?, 'should pass valid files'
  end

  def test_check_should_pass_if_staged_file_list_is_empty
    check = Sanity.new
    check.staged_files = []
    assert check.run
  end

end
