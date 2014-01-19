require 'minitest_helper'
require 'plugins/pre_commit/checks/whitespace'

describe PreCommit::Checks::Whitespace do
  before do
    create_temp_dir
    start_git
    sh "touch a && git add a && git commit -am 'a'"
  end
  after(&:destroy_temp_dir)

  let(:check){ PreCommit::Checks::Whitespace.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    `echo aaa > b && git add b`
    check.call([]).must_equal nil
  end

  it "fails on bad changes" do
    `echo '   ' > b && git add b`
    check.call([]).must_equal "b:1: trailing whitespace.\n+   \nb:1: new blank line at EOF.\n"
  end
end
