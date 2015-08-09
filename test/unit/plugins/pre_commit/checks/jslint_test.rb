require 'minitest_helper'
require 'plugins/pre_commit/checks/jslint'

describe PreCommit::Checks::Jslint do
  let(:check){ PreCommit::Checks::Jslint.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([fixture_file('valid_file.js')]).must_equal nil
  end
end
