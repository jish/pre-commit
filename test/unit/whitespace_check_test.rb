require 'minitest_helper'
require 'pre-commit/checks/whitespace_check'
require 'tmpdir'

describe PreCommit::WhiteSpaceCheck do
  def cmd(command)
    `#{command}`
    raise unless $?.success?
  end

  around do |test|
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        `git init && touch a && git add a && git commit -am 'a'`
        raise unless $?.success?
        test.call
      end
    end
  end

  let(:check){ PreCommit::WhiteSpaceCheck }

  it "succeeds if nothing changed" do
    check.run([]).must_equal nil
  end

  it "succeeds if only good changes" do
    `echo aaa > b && git add b`
    check.run([]).must_equal nil
  end

  it "fails on bad changes" do
    `echo '   ' > b && git add b`
    check.run([]).must_equal "b:1: trailing whitespace.\n+   \nb:1: new blank line at EOF.\n"
  end
end
