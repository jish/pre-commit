require 'minitest_helper'
require 'pre-commit/utils/grep'

describe PreCommit::Utils::Grep do
  subject do
    Object.new.send(:extend, PreCommit::Utils::Grep)
  end

  it "finds grep for FreeBSD" do
    subject.grep('FreeBSD').must_equal("grep -EnIH")
  end

  it "finds grep for other systems" do
    subject.grep('other systems').must_equal("grep -PnIH")
  end

  it "detects grep version" do
    subject.send(:detect_grep_version).must_match(/grep/)
  end

end

