require 'minitest_helper'
require 'pre-commit/utils'
require 'plugins/pre-commit/checks/before_all_check'

describe PreCommit::BeforeAllCheck do
  let(:check){ PreCommit::BeforeAllCheck }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([test_filename('valid_spec.rb')]).must_equal nil
  end

  it "fails if file contains before(:all)" do
    check.call([test_filename('before_all_spec.rb')]).must_equal(
      "before(:all) found:\ntest/files/before_all_spec.rb:2:  before(:all) do")
  end

  it "fails if file contains before :all" do
    check.call([test_filename('before_all_spec_2.rb')]).must_equal(
      "before(:all) found:\ntest/files/before_all_spec_2.rb:2:  before :all do")
  end
end
