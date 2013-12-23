require 'minitest_helper'
require 'pre-commit/configuration'

describe PreCommit::Configuration do
  subject do
    PreCommit::Configuration.new(nil, {
      :value => 'simple',
      :test         => %w{5 6 7},
      :test_add    => %w{8},
      :test_remove => "6",
    })
  end

  it "reads values" do
    subject.get(:value).must_equal('simple')
  end

  it "reads array values" do
    subject.get_arr(:value).must_equal(%w{simple})
  end

  it "converts strings to arrays" do
    subject.send(:str2arr, "test, some,string").must_equal(%w{test some string})
  end

  it "reads arrays directly" do
    subject.send(:ensure_arr, [1,2,3]).must_equal([1,2,3])
  end

  it "reads strings as array" do
    subject.send(:ensure_arr, '1, 2').must_equal(%w{1 2})
  end

  it "reads nil as array" do
    subject.send(:ensure_arr, nil).must_equal([])
  end

  it "reads empty string array" do
    subject.send(:ensure_arr, '').must_equal([])
  end

  it "calculates checks" do
    subject.get_combined_arr(:test).must_equal(%w{5 7 8})
  end

end
