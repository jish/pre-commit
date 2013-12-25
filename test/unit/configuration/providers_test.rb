require 'minitest_helper'
require 'pre-commit/configuration/providers'
require 'plugins/pre_commit/configuration/providers/default'
require 'plugins/pre_commit/configuration/providers/git'
require 'pluginator'

describe PreCommit::Configuration::Providers do
  subject do
    PreCommit::Configuration::Providers
  end

  it "detects plugins" do
    provider = subject.new(Pluginator.find("pre_commit"))
    provider.send(:plugins)[0].must_be_instance_of(PreCommit::Configuration::Providers::Default)
    provider.send(:plugins).size.must_be(:>=, 3)
  end

  describe "filesystem" do
    before do
      create_temp_dir
      start_git
      @defaults = {:test1 => 1, :test2 => 2, :test3 => 3}
      @plugins  = [
        PreCommit::Configuration::Providers::Default.new(@defaults),
        PreCommit::Configuration::Providers::Git.new,
        PreCommit::Configuration::Providers::Yaml.new,
      ]

      sh "git config pre-commit.test1 4"
      sh "git config pre-commit.test2 5"
      Dir.mkdir("config")
      File.open("config/pre_commit.yml", "w") do |file|
        file.write <<-DATA
---
:test1: 6
DATA
      end
    end
    after(&:destroy_temp_dir)

    it "reads configurations" do
      provider = subject.new(nil, @plugins)
      provider[:test1].must_equal(6)
      provider[:test2].must_equal("5")
      provider[:test3].must_equal(3)
      provider[:test4].must_equal(nil)
    end

    it "updates git configurations" do
      provider = subject.new(nil, @plugins)
      provider.update('git', 'test1', "7")
      sh("git config pre-commit.test1").strip.must_equal("7")
    end

    it "updates yaml configurations" do
      provider = subject.new(nil, @plugins)
      provider.update('yaml', 'test2', 8)
      File.open("config/pre_commit.yml", "r") do |file|
        file.read.must_equal(<<-EXPECTED)
---
:test1: 6
:test2: 8
EXPECTED
      end
    end

    it "update add configurations" do
      sh "git config pre-commit.test.array '[:one, :two]'"
      provider = subject.new(nil, @plugins)
      provider.update_add('git', 'test.array', [:three])
      sh("git config pre-commit.test.array").strip.must_equal("[:one, :two, :three]")
    end

    it "update remore configurations" do
      sh "git config pre-commit.test.array '[:one, :two]'"
      provider = subject.new(nil, @plugins)
      provider.update_remove('git', 'test.array', [:one])
      sh("git config pre-commit.test.array").strip.must_equal("[:two]")
    end

  end

end
