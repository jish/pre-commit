require 'minitest_helper'
require 'pre-commit/configuration'
require 'plugins/pre_commit/configuration/providers/default'
require 'plugins/pre_commit/configuration/providers/git'

describe PreCommit::Configuration do
  describe "fake" do
    subject do
      PreCommit::Configuration.new(nil, {
        :value       => 'simple',
        :test        => %w{5 6 7},
        :test_add    => %w{8},
        :test_remove => %w{6},
      })
    end

    it "reads values" do
      subject.get(:value).must_equal('simple')
    end

    it "reads using string" do
      subject.get("value").must_equal('simple')
    end

    it "fails to read string as array" do
      ->(){ subject.get_arr(:value) }.must_raise(PreCommit::NotAnArray)
    end

    it "calculates checks" do
      subject.get_combined(:test).must_equal(%w{5 7 8})
    end
  end

  describe "filesystem" do
    before do
      create_temp_dir
      start_git
      sh "git config pre-commit.test.add    '[:one, :two]'"
      sh "git config pre-commit.test.remove '[:three, :four]'"
    end
    after(&:destroy_temp_dir)
    subject do
      PreCommit::Configuration.new(nil, PreCommit::Configuration::Providers.new(nil, [
        PreCommit::Configuration::Providers::Default.new({}),
        PreCommit::Configuration::Providers::Git.new,
      ]))
    end

    it "enables list configuration" do
      subject.enable('git', 'test', 'three')
      sh("git config pre-commit.test.add").strip.must_equal("[:one, :two, :three]")
      sh("git config pre-commit.test.remove").strip.must_equal("[:four]")
    end

    it "disables list configuration" do
      subject.disable('git', 'test', 'two')
      sh("git config pre-commit.test.add").strip.must_equal("[:one]")
      sh("git config pre-commit.test.remove").strip.must_equal("[:three, :four, :two]")
    end

  end

end
