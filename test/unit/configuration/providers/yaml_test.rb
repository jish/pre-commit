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
      Dir.mkdir("config")
      File.open("config/pre_commit.yml", "w") do |file|
        file.write <<-DATA
---
:test1: 5
:test3: 6
DATA
      end
    end
    after(&:destroy_temp_dir)

    it "reads values" do
      example = subject.new
      example[:test1].must_equal(5)
      example[:test2].must_equal(nil)
      example[:test3].must_equal(6)
    end
  end
end
