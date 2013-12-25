require 'minitest_helper'
require 'plugins/pre_commit/checks/php'

describe PreCommit::Checks::Php do
  let(:check){ PreCommit::Checks::Php.new(nil, nil) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if non-php file changed" do
    check.call([test_filename('bad-php.js')]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([test_filename("good.php")]).must_equal nil
  end

  it "fails if script fails" do
    check.call([test_filename("bad.php")]).must_match(/Parse error/i)
  end
end
