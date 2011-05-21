require 'minitest/autorun'
require 'pre-commit/checks/jslint_check'

# TODO remove this #ugly
require 'pre-commit/checks'

class JslintCheckTest < MiniTest::Unit::TestCase

  def test_should_not_run_if_staged_files_is_empty
    check = PreCommit::JslintCheck.new

    assert check.should_run?(['foo.js'])

    assert !check.should_run?([])
  end

  def test_should_run_all_by_default
    check = PreCommit::JslintCheck.new
    assert_equal :all, check.type
  end

  def test_should_run_new_if_specified
    check = PreCommit::JslintCheck.new(:new)
    assert_equal :new, check.type
  end

end
