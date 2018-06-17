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
    check.call(['a']).must_be_nil
  end

  it "succeeds if only good changes" do
    `echo aaa > b && git add b`
    check.call(['a', 'b']).must_be_nil
  end

  describe 'staged bad changes' do
    it "fails on bad changes" do
      `echo '   ' > b && git add b`
      check.call(['a', 'b']).must_equal "b:1: trailing whitespace.\n+   \nb:1: new blank line at EOF.\n"
    end

    it "succeeds if the target files don't have bad changes" do
      `echo '   ' > b && git add b`
      check.call(['a']).must_be_nil
    end

    it "succeeds if no target files" do
      `echo '   ' > b && git add b`
      check.call([]).must_be_nil
    end
  end
end
