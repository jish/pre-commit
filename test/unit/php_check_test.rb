require 'minitest_helper'
require 'pre-commit/checks/php_check'

describe PreCommit::PhpCheck do
  let(:check){ PreCommit::PhpCheck }

  it "succeeds if nothing changed" do
    check.run([]).must_equal nil
  end

  it "succeeds if non-php file changed" do
    check.run([test_filename('bad-php.js')]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.run([test_filename("good.php")]).must_equal nil
  end

  it "fails if script fails" do
    check.run([test_filename("bad.php")]).must_equal "Parse error: parse error in test/files/bad.php on line 1"
  end
end
