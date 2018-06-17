require 'minitest_helper'
require 'pre-commit/checks/js'

describe PreCommit::Checks::Js do
  let(:check){ PreCommit::Checks::Js.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_be_nil
  end

  it "succeeds if non-js changed" do
    check.call(["bar.foo"]).must_be_nil
  end
end
