require 'minitest_helper'
require 'plugins/pre_commit/checks/scss_lint'

describe PreCommit::Checks::ScssLint do
  let(:config) do
    mock = MiniTest::Mock.new
    mock.expect(:get, '', ['scss_lint.config'])
    mock
  end
  let(:check) {PreCommit::Checks::ScssLint.new(nil, config, [])}

  it "succeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds for good code" do
    check.call([fixture_file('good.scss')]).must_equal nil
  end

  it "fails for bad formatted code" do
    check.call([fixture_file("bad.scss")]).must_equal <<-ERROR
test/files/bad.scss:9 [W] Properties should be sorted in order, with vendor-prefixed extensions before the standardized CSS property
test/files/bad.scss:18 [W] Properties should be sorted in order, with vendor-prefixed extensions before the standardized CSS property
test/files/bad.scss:19 [W] `0.2` should be written without a leading zero as `.2`
test/files/bad.scss:25 [W] Properties should be sorted in order, with vendor-prefixed extensions before the standardized CSS property
test/files/bad.scss:27 [W] Rule declaration should be followed by an empty line
test/files/bad.scss:28 [W] Each selector in a comma sequence should be on its own line
ERROR
  end
end
