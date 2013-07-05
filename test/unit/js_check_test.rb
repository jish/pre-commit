require 'minitest_helper'
require 'pre-commit/checks/js_check'

describe PreCommit::JsCheck do
  let(:check){ PreCommit::JsCheck }

  it "succeeds if nothing changed" do
    check.run([]).must_equal nil
  end

  it "succeeds if non-js changed" do
    check.run(["bar.foo"]).must_equal nil
  end
end
