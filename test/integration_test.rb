require 'minitest_helper'
require "tmpdir"
require "pre-commit/cli"

describe "integration" do
  it "prevents bad commits" do
    in_git_dir do
      result = commit_a_bad_file :fail => true
      assert_includes result, "detected tab before initial"
      assert_includes result, "new blank line at EOF"
      assert_includes result, "You can bypass this check using"
    end
  end

  it "bypasses pre-commit checks when using the no-verify option" do
    in_git_dir do
      write("xxx.rb", "\t\tMuahaha\n\n\n")
      sh "git add -A"
      result = Bundler.with_clean_env { sh("git commit -n -m 'EVIL'") }
      refute_includes result, "detected tab before initial"
      assert_includes result, "create mode 100644 xxx.rb"
    end
  end

  it "does not prevent bad commits when checks are disabled" do
    in_git_dir do
      sh "git config 'pre-commit.checks' 'jshint'"
      result = commit_a_bad_file
      refute_includes result, "detected tab before initial"
      assert_includes result, "create mode 100644 xxx.rb"
    end
  end

  it "prevents bad commits when certain checks are enabled" do
    in_git_dir do
      sh "git config 'pre-commit.checks' 'tabs'"
      result = commit_a_bad_file :fail => true
      assert_includes result, "detected tab before initial"
      refute_includes result, "new blank line at EOF"
      assert_includes result, "You can bypass this check using"
    end
  end

  def in_git_dir(&block)
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        sh "git init"
        install
        yield
      end
    end
  end

  def commit_a_bad_file(options={})
    write("xxx.rb", "\t\tMuahaha\n\n\n")
    sh "git add -A"
    Bundler.with_clean_env { sh("git commit -m 'EVIL'", options) }
  end

  def sh(command, options={})
    result = `#{command} 2>&1`
    raise "FAILED #{command}\n#{result}" if $?.success? == !!options[:fail]
    result
  end

  def install
    sh "ruby -I #{Bundler.root}/lib #{Bundler.root}/bin/pre-commit install"
    make_lib_available_for_hook
    sh "git commit -m Initial --allow-empty" # or travis fails with: No HEAD commit to compare with
  end

  def make_lib_available_for_hook
    hook_file = PreCommit::Cli::PRE_COMMIT_HOOK_PATH
    anchor = "-r pre-commit"
    content = read(hook_file)
    raise unless content.include?(anchor)
    write(hook_file, content.gsub(anchor, "#{anchor} -I #{Bundler.root.join("lib")}"))
  end

  def ensure_folder(folder)
    FileUtils.mkdir_p(folder) unless File.exist?(folder)
  end

  def write(file, content)
    ensure_folder File.dirname(file)
    File.open(file, 'w'){|f| f.write content }
  end

  def read(file)
    File.read file
  end
end
