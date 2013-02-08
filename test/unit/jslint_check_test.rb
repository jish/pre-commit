require File.expand_path('../../minitest_helper', __FILE__)
require 'pre-commit/checks/jslint_check'

class JslintCheckTest < MiniTest::Unit::TestCase

  def test_should_run_all_by_default
    check = PreCommit::JslintCheck.new
    assert_equal :all, check.type
  end

  def test_should_run_new_if_specified
    check = PreCommit::JslintCheck.new(:new)
    assert_equal :new, check.type
  end

end
