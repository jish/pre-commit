require 'minitest_helper'
require 'plugins/pre_commit/checks/jslint'

describe PreCommit::Checks::Jslint do
  let(:check){ PreCommit::Checks::Jslint.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_be_nil
  end

  it "succeeds if only good changes" do
    check.call([fixture_file('valid_file.js')]).must_be_nil
  end

  it "fails if file contains debugger" do
    skip do
      check.call([fixture_file('bad_file.js')]).must_equal "Missing semicolon.\ntest/files/bad_file.js:5 }"
    end
  end
end
