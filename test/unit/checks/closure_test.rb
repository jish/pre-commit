require 'minitest_helper'
require 'plugins/pre_commit/checks/closure'

describe PreCommit::Checks::Closure do
  let(:check){ PreCommit::Checks::Closure.new(nil, nil) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([test_filename('valid_file.js')]).must_equal nil
  end

  it "fails if file contains debugger" do
    check.call([test_filename('bad_closure.js')]).must_include "test/files/bad_closure.js:2: WARNING - Suspicious code"
  end
end
