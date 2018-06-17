require 'minitest_helper'
require 'plugins/pre_commit/checks/ci'

describe PreCommit::Checks::Ci do
  let(:check) { PreCommit::Checks::Ci.new(nil, nil, []) }

  it "succeeds if rake succeeds" do
    check.stub :system, true do
      check.call([]).must_be_nil
    end
  end

  it "fails if rake fails" do
    check.stub :system, false do
      check.call([]).to_s.must_equal "your test suite has failed, for the full output run `pre_commit:ci`"
    end
  end
end
