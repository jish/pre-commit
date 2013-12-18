require 'minitest_helper'
require 'plugins/pre_commit/checks/js'

describe PreCommit::Checks::Js do
  let(:check){ PreCommit::Checks::Js }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if non-js changed" do
    check.call(["bar.foo"]).must_equal nil
  end
end
