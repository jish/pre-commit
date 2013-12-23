require 'minitest_helper'
require 'plugins/pre_commit/configuration/providers/default'

describe PreCommit::Configuration::Providers::Default do
  subject do
    PreCommit::Configuration::Providers::Default
  end

  it "has priority" do
    subject.priority.must_equal(0)
  end

  it "has defaults" do
    subject::DEFAULTS.must_be_kind_of(Hash)
    subject::DEFAULTS.keys.must_include(:warnings)
    subject::DEFAULTS.keys.must_include(:checks)
  end

  it "uses DEFAULTS" do
    example = subject.new
    example.instance_variable_get(:@defaults).must_equal(subject::DEFAULTS)
  end

  it "reads default values" do
    example = subject.new({:test1 => 1, :test2 => 2})
    example[:test1].must_equal(1)
    example[:test2].must_equal(2)
    example[:test3].must_equal(nil)
  end
end
