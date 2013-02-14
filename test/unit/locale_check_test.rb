require 'minitest_helper'
require 'pre-commit/checks/local_check'

describe PreCommit::LocalCheck do
  let(:check){ PreCommit::LocalCheck.new }
  let(:config_file){ test_filename("pre-commit.rb") }

  it "succeeds if there is no config" do
    PreCommit::LocalCheck.call.must_equal true
  end

  it "succeeds if script succeeds" do
    check.run(config_file, "").must_equal true
  end

  it "fails if script fails" do
    check.run(config_file, "xxx").must_equal false
  end
end
