require 'minitest_helper'
require 'pre-commit/checks/ci_check'

describe PreCommit::CiCheck do
  let(:check) { PreCommit::CiCheck }

  it "succeeds if rake succeeds" do
    check.stub :system, true do
      check.call([]).must_equal nil
    end
  end

  it "fails if rake fails" do
    check.stub :system, false do
      check.call([]).must_equal "your test suite has failed, for the full output run `pre_commit:ci`"
    end
  end
end
