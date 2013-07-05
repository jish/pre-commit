require 'minitest_helper'
require 'pre-commit/checks/closure_check'

describe PreCommit::ClosureCheck do
  let(:check){ PreCommit::ClosureCheck }

  it "succeeds if nothing changed" do
    check.run([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.run([test_filename('valid_file.js')]).must_equal nil
  end

  it "fails if file contains debugger" do
    check.run([test_filename('bad_closure.js')]).must_include "test/files/bad_closure.js:2: WARNING - Suspicious code"
  end
end
