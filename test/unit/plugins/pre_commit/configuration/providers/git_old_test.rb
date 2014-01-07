require 'minitest_helper'
require 'plugins/pre_commit/configuration/providers/git_old'

describe PreCommit::Configuration::Providers::GitOld do
  subject do
    PreCommit::Configuration::Providers::GitOld
  end

  it "has priority" do
    subject.priority.must_equal(11)
  end

  describe :filesystem do
    before do
      create_temp_dir
      start_git
      sh "git config pre-commit.checks jshint,local"
      sh "git config pre-commit.other jshint,local"
    end
    after(&:destroy_temp_dir)

    it "reads values" do
      example = subject.new
      example[:test1].must_equal(nil)
      example[:checks].must_equal([:jshint, :local])
      example[:other].must_equal("jshint,local")
    end

    it "saves values" do
      example = subject.new
      example[:checks]
      example[:other]
      sh("git config pre-commit.checks").strip.must_equal("[:jshint, :local]")
      sh("git config pre-commit.other").strip.must_equal("jshint,local")
    end
  end
end
