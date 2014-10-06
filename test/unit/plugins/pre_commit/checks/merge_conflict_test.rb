require 'minitest_helper'
require 'plugins/pre_commit/checks/merge_conflict'

describe PreCommit::Checks::MergeConflict do
  let(:check){ PreCommit::Checks::MergeConflict.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([fixture_file('valid_file.rb')]).must_equal nil
  end

  it "fails if file contains merge conflict" do
    check.call([fixture_file('merge_conflict.rb')]).to_a.must_equal([
      "detected a merge conflict",
      "test/files/merge_conflict.rb:3:<<<<<<< HEAD"
    ])
  end
end
