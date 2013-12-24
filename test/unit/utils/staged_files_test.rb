require 'minitest_helper'
require 'pre-commit/utils/staged_files'

describe PreCommit::Utils::StagedFiles do
  before do
    create_temp_dir
    start_git
  end
  after(&:destroy_temp_dir)
  subject do
    Object.new.send(:extend, PreCommit::Utils::StagedFiles)
  end

  it "finds staged files" do
    write("test.rb", "\t\t Muahaha\n\n\n")
    sh "git add -A"
    subject.staged_files.must_equal(['test.rb'])
  end

  it "has empty list for no changes" do
    subject.staged_files.must_equal([])
  end

end
