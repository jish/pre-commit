require 'minitest_helper'
require 'plugins/pre_commit/checks/local'

describe PreCommit::Checks::Local do

  let(:config_file) { fixture_file("pre-commit.rb") }
  let(:check) { PreCommit::Checks::Local.new(nil, nil, []) }

  it "succeeds if there is no config" do
    check.call([]).must_equal nil
  end

  it "succeeds if script succeeds" do
    check.script = config_file
    check.call([]).must_equal nil
  end

  it "fails if script fails" do
    check.script = config_file
    check.call(["xxx"]).must_include "pre-commit.rb failed"
  end

  it "finds a local script" do
    in_tmpdir do
      FileUtils.mkdir_p("config")
      FileUtils.touch(File.join("config", "pre-commit.rb"))
      check.script.must_equal "config/pre-commit.rb"
    end
  end

  it "finds a local script with an underscored name" do
    in_tmpdir do
      FileUtils.mkdir_p("config")
      FileUtils.touch(File.join("config", "pre_commit.rb"))
      check.script.must_equal "config/pre_commit.rb"
    end
  end

  it "prefers the underscored local script name" do
    in_tmpdir do
      FileUtils.mkdir_p("config")
      FileUtils.touch(File.join("config", "pre_commit.rb"))
      FileUtils.touch(File.join("config", "pre-commit.rb"))
      check.script.must_equal "config/pre_commit.rb"
    end
  end

end
