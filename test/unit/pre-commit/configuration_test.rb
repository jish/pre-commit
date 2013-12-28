require 'minitest_helper'
require 'pre-commit/configuration'
require 'plugins/pre_commit/configuration/providers/default'
require 'plugins/pre_commit/configuration/providers/git'
require 'plugins/pre_commit/checks/before_all'
require 'plugins/pre_commit/checks/console_log'

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
      $stderr = StringIO.new
      $stdout = StringIO.new
    end
    after do
      destroy_temp_dir
      $stderr = STDERR
      $stdout = STDOUT
    end
    subject do
      PreCommit::Configuration.new(
        {'checks' => [
          PreCommit::Checks::BeforeAll,
          PreCommit::Checks::ConsoleLog
        ]},
        PreCommit::Configuration::Providers.new(nil, [
          PreCommit::Configuration::Providers::Default.new({}),
          PreCommit::Configuration::Providers::Git.new,
        ])
      )
    end

    it "enables list configuration" do
      subject.enable('git', 'test', 'three').must_equal(true)
      sh("git config pre-commit.test.add").strip.must_equal("[:one, :two, :three]")
      sh("git config pre-commit.test.remove").strip.must_equal("[:four]")
    end

    it "disables list configuration" do
      subject.disable('git', 'test', 'two').must_equal(true)
      sh("git config pre-commit.test.add").strip.must_equal("[:one]")
      sh("git config pre-commit.test.remove").strip.must_equal("[:three, :four, :two]")
    end

    it "handles missing enable plugin" do
      subject.enable('unknown', 'test', 'two').must_equal(false)
      $stderr.string.strip.must_match('Plugin not found for unknown.')
      $stdout.string.must_equal('')
    end

    it "handles missing disable plugin" do
      subject.disable('another', 'test', 'two').must_equal(false)
      $stderr.string.strip.must_match('Plugin not found for another.')
      $stdout.string.must_equal('')
    end

    it :list do
      subject.list.gsub(/\s+\n/,"\n").must_equal(<<-EXPECTED)
Available providers: default(0) git(10)
Available checks   : before_all console_log
Default   checks   :
Enabled   checks   :
Default   warnings :
Enabled   warnings :
EXPECTED
    end

  end

end
