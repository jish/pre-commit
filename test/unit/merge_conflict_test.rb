require 'minitest_helper'
require 'pre-commit/checks/merge_conflict'

class MergeConflictTest < MiniTest::Unit::TestCase

  def test_should_detect_a_merge_conflict
    check = PreCommit::MergeConflict.new
    check.staged_files = test_filename('merge_conflict.rb')
    assert check.detected_bad_code?, 'We should prevent a merge conflict from being committed'
  end

  def test_should_pass_a_file_with_no_merge_conflicts
    check = PreCommit::MergeConflict.new
    check.staged_files = test_filename('valid_file.rb')
    assert !check.detected_bad_code?, 'A file with no merge conflicts should pass'
  end

end
