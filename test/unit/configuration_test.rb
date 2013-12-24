require 'minitest_helper'
require 'pre-commit/configuration'

describe PreCommit::Configuration do
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

  it "calculates checks" do
    subject.get_combined(:test).must_equal(%w{5 7 8})
  end

end
