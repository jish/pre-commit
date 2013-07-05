require 'minitest_helper'
require 'pre-commit/checks/jslint_check'

describe PreCommit::JslintCheck do
  let(:check){ PreCommit::JslintCheck }

  it "succeeds if nothing changed" do
    check.run([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.run([test_filename('valid_file.js')]).must_equal nil
  end

  it "fails if file contains debugger" do
    skip do
      check.run([test_filename('bad_file.js')]).must_equal "Missing semicolon.\ntest/files/bad_file.js:5 }"
    end
  end
end
