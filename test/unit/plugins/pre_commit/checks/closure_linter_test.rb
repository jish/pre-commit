require 'minitest_helper'
require 'plugins/pre_commit/checks/closure_linter'

describe PreCommit::Checks::ClosureLinter do
  let(:check){ PreCommit::Checks::ClosureLinter.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([fixture_file('valid_file.js')]).must_equal nil
  end

  it "fails if file contains debugger" do
    text = "Line 2, E:0010: Missing semicolon at end of line\nFound 2 errors"
    check.call([fixture_file('bad_closure.js')]).must_include text
  end
end
