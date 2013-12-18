require 'minitest_helper'
require 'plugins/pre_commit/checks/js_check'

describe PreCommit::Checks::JsCheck do
  let(:check){ PreCommit::Checks::JsCheck }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if non-js changed" do
    check.call(["bar.foo"]).must_equal nil
  end
end
