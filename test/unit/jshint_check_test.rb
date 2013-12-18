require 'minitest_helper'
require 'plugins/pre-commit/checks/jshint_check'

describe PreCommit::JshintCheck do
  let(:check){ PreCommit::JshintCheck }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([test_filename('valid_file.js')]).must_equal nil
  end

  it "fails if file contains debugger" do
    check.call([test_filename('bad_file.js')]).must_equal "Missing semicolon.\ntest/files/bad_file.js:5 }"
  end
end
