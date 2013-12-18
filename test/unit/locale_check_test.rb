require 'minitest_helper'
require 'plugins/pre-commit/checks/local_check'

describe PreCommit::LocalCheck do
  let(:config_file) { test_filename("pre-commit.rb") }
  let(:check) { PreCommit::LocalCheck }

  it "succeeds if there is no config" do
    check.call([]).must_equal nil
  end

  it "succeeds if script succeeds" do
    check.call([], config_file).must_equal nil
  end

  it "fails if script fails" do
    check.call(["xxx"], config_file).must_include "pre-commit.rb failed"
  end
end
