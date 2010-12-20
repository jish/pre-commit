require 'minitest/autorun'
require 'fileutils'

require 'pre-commit/utils'

class UtilsTest < MiniTest::Unit::TestCase

  def test_should_reject_non_existent_directories
    FileUtils.mkdir_p('/tmp/pre-commit/foo')
    assert File.exist?('/tmp/pre-commit/foo')
    assert !File.exist?('/tmp/pre-commit/bar'),
      'This tests depends on the non-existence of `/tmp/pre-commit/bar` ' +
      'please ensure it does not contain any important files and delete it.'

    result = Utils.reject_missing(['/tmp/pre-commit/foo', '/tmp/pre-commit/bar'])
    assert_equal(['/tmp/pre-commit/foo'].first, result.first)
  end

end
