require File.expand_path('../minitest_helper', __FILE__)
require "tmpdir"

describe "integration" do
  it "prevents bad commits" do
    in_git_dir do
      result = commit_a_bad_file :fail => true
      assert_includes result, "detected tab before initial"
      assert_includes result, "xxx.rb:2: new blank line at EOF"
      assert_includes result, "You can bypass this check using"
    end
  end

  it "does not prevents bad commits when after-commit-hooks are disabled" do
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
      refute_includes result, "xxx.rb:2: new blank line at EOF"
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
  end

  def ensure_folder(folder)
    `mkdir -p #{folder}` unless File.exist?(folder)
  end

  def write(file, content)
    ensure_folder File.dirname(file)
    File.open(file, 'w'){|f| f.write content }
  end

  def read(file)
    File.read file
  end
end
