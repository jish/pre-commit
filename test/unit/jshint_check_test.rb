require 'minitest/autorun'
require 'pre-commit/checks/jshint_check'

class JshintCheckTest < MiniTest::Unit::TestCase

  def test_should_not_run_if_therubyracer_is_not_installed
    check = PreCommit::JshintCheck.new

    check.therubyracer_installed = false
    assert !check.should_run?(['foo.js'])

    check.therubyracer_installed = true
    assert check.should_run?(['foo.js'])
  end

  def test_should_not_run_if_staged_files_is_empty
    check = PreCommit::JshintCheck.new
    check.therubyracer_installed = true

    assert check.should_run?(['foo.js'])

    assert !check.should_run?([])
  end

  def test_should_know_where_the_jshint_source_code_is
    check = PreCommit::JshintCheck.new
    expected = File.join(PreCommit.root, 'lib/support/jshint/jshint.js')
    assert_equal(expected, check.jshint_src)
  end

  def test_should_reject_staged_files_that_are_not_js_files
    check = PreCommit::JshintCheck.new
    assert_equal(['bar.js'], check.reject_non_js(['foo.rb', 'bar.js']))
  end

  def test_should_display_errors
    check = PreCommit::JshintCheck.new
    error_object = {
      'reason' => 'forgot semi-colon',
      'evidence' => 'var foo = bar',
      'line' => '14'
    }

    expected = "pre-commit: JSHINT forgot semi-colon\nfoo.js:15 var foo = bar"
    assert_equal(expected, check.display_error(error_object, 'foo.js'))
  end

end
