require 'minitest_helper'
require 'plugins/pre_commit/checks/whitespace_check'

describe PreCommit::Checks::WhitespaceCheck do
  def cmd(command)
    `#{command}`
    raise unless $?.success?
  end

  in_temp_dir do
    `git init && touch a && git add a && git commit -am 'a'`
    raise unless $?.success?
  end

  let(:check){ PreCommit::Checks::WhitespaceCheck }

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
