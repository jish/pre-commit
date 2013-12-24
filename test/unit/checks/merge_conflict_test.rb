require 'minitest_helper'
require 'plugins/pre_commit/checks/merge_conflict'

describe PreCommit::Checks::MergeConflict do
  let(:check){ PreCommit::Checks::MergeConflict.new }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([test_filename('valid_file.rb')]).must_equal nil
  end

  it "fails if file contains merge conflict" do
    check.call([test_filename('merge_conflict.rb')]).must_equal(<<-EXPECTED)
detected a merge conflict
test/files/merge_conflict.rb:3:<<<<<<< HEAD
EXPECTED
  end
end
