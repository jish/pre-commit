require 'minitest_helper'
require 'plugins/pre-commit/checks/php_check'

describe PreCommit::PhpCheck do
  let(:check){ PreCommit::PhpCheck }

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
    possible = [
      "Parse error: syntax error, unexpected T_STRING in test/files/bad.php on line 1",
      "Parse error: parse error in test/files/bad.php on line 1"
    ]
    possible.must_include check.call([test_filename("bad.php")])
  end
end
