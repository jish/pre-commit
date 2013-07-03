require 'minitest_helper'
require 'pre-commit/checks/local_check'

describe PreCommit::LocalCheck do
  let(:config_file) { test_filename("pre-commit.rb") }
  let(:check) { PreCommit::LocalCheck }

  it "succeeds if there is no config" do
    check.run([]).must_equal nil
  end

  it "succeeds if script succeeds" do
    check.run([], config_file).must_equal nil
  end

  it "fails if script fails" do
    check.run(["xxx"], config_file).must_include "pre-commit.rb failed"
  end
end
