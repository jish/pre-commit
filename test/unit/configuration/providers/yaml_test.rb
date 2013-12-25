require 'minitest_helper'
require 'plugins/pre_commit/configuration/providers/yaml'

describe PreCommit::Configuration::Providers::Yaml do
  subject do
    PreCommit::Configuration::Providers::Yaml
  end

  it "has priority" do
    subject.priority.must_equal(20)
  end

  describe :filesystem do
    before do
      create_temp_dir
      start_git
      @system_file = "etc_pre_commit.yml"
      @global_file = ".pre_commit.yml"
      preprare_file(@system_file, SYSTEM_DATA)
    end
    after(&:destroy_temp_dir)

    it "reads system values" do
      example = subject.new
      example.instance_variable_set(:@system_file, @system_file)
      example.instance_variable_set(:@global_file, @global_file)
      example[:test1].must_equal(1)
      example[:test2].must_equal(2)
      example[:test3].must_equal(3)
      example[:test4].must_equal(nil)
    end

    it "reads system and global values" do
      preprare_file(@global_file, GLOBAL_DATA)
      example = subject.new
      example.instance_variable_set(:@system_file, @system_file)
      example.instance_variable_set(:@global_file, @global_file)
      example[:test1].must_equal(4)
      example[:test2].must_equal(5)
      example[:test3].must_equal(3)
      example[:test4].must_equal(nil)
    end

    it "reads system and local values" do
      Dir.mkdir("config")
      preprare_file("config/pre_commit.yml", LOCAL_DATA)
      example = subject.new
      example.instance_variable_set(:@system_file, @system_file)
      example.instance_variable_set(:@global_file, @global_file)
      example[:test1].must_equal(6)
      example[:test2].must_equal(2)
      example[:test3].must_equal(3)
      example[:test4].must_equal(nil)
    end
    it "reads system and local values" do
      preprare_file(@global_file, GLOBAL_DATA)
      Dir.mkdir("config")
      preprare_file("config/pre_commit.yml", LOCAL_DATA)
      example = subject.new
      example.instance_variable_set(:@system_file, @system_file)
      example.instance_variable_set(:@global_file, @global_file)
      example[:test1].must_equal(6)
      example[:test2].must_equal(5)
      example[:test3].must_equal(3)
      example[:test4].must_equal(nil)
    end
  end

  def preprare_file(name, content)
    File.open(name, "w") {|file| file.write(content) }
  end

  SYSTEM_DATA = <<-DATA
---
:test1: 1
:test2: 2
:test3: 3
DATA

  GLOBAL_DATA = <<-DATA
---
:test1: 4
:test2: 5
DATA

  LOCAL_DATA = <<-DATA
---
:test1: 6
DATA

end
