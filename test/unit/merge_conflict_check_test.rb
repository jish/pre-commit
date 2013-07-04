require 'minitest_helper'
require 'pre-commit/checks/merge_conflict_check'

describe PreCommit::MergeConflictCheck do
  let(:check){ PreCommit::MergeConflictCheck }

  it "succeeds if nothing changed" do
    check.run([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.run([test_filename('valid_file.rb')]).must_equal nil
  end

  it "fails if file contains merge conflict" do
    check.run([test_filename('merge_conflict.rb')]).must_equal "detected a merge conflict\ntest/files/merge_conflict.rb:3:<<<<<<< HEAD"
  end
end
