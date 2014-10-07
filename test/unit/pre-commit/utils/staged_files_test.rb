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

  describe :staged_files do

    it "finds staged files" do
      write("test.rb", "\t\t Muahaha\n\n\n")
      sh "git add -A"
      subject.staged_files.must_equal(['test.rb'])
    end

    it "filters out binary files" do
      write("test.rb", (1..50).map(&:chr).join)
      sh "git add -A"
      subject.staged_files.must_equal([])
    end


    it "has empty list for no changes" do
      subject.staged_files.must_equal([])
    end

    it "sets staged files" do
      subject.staged_files.must_equal([])
      subject.set_staged_files("some_file", "another_file")
      subject.staged_files.must_equal(["some_file", "another_file"])
    end

    it "does not include links to nowhere" do
      write("something.rb", "class Something; end")
      write("nowhere.rb", "")
      FileUtils.ln_s("nowhere.rb", "link_to_nowhere.rb")
      FileUtils.rm("nowhere.rb")
      system("git", "add", "-A")
      subject.staged_files.must_equal ["something.rb"]
    end

  end # :staged_files

  describe :repo_ignores do

    it "builds ignores file path" do
      subject.send(:repo_ignores_file).must_match(%r{.*/.pre_commit.ignore$})
    end

    it "does not fail without ignore file" do
      subject.send(:repo_ignores).must_equal []
    end

    it "does read ignores file" do
      write(".pre_commit.ignore", "file.rb\n")
      subject.send(:repo_ignores).must_equal ["file.rb"]
    end

    it "it does exclude links from ignore file" do
      write(".pre_commit.ignore", "file.rb\n")
      write("something.rb", "")
      write("file.rb", "")
      system("git", "add", "-A")
      subject.staged_files.sort.must_equal [".pre_commit.ignore", "something.rb"].sort
    end

  end # :repo_ignores

  describe :staged_files_all do

    it "lists all files" do
      write("something.rb", "")
      write("file.rb", "")
      subject.staged_files_all.sort.must_equal ["file.rb", "something.rb"].sort
    end

  end

end
