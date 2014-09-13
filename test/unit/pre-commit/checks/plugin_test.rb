require 'minitest_helper'
require 'pre-commit/checks/plugin'

describe PreCommit::Checks::Plugin do

  subject do
    PreCommit::Checks::Plugin.new(nil, nil, [])
  end

  it "succeeds if nothing changed" do
    subject.send(:in_groups, [1,2,3,4], 2).to_a.must_equal [[1,2], [3,4]]
  end

end
