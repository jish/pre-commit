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
test/files/bad.scss:2 [W] Properties should be sorted in order, with vendor-prefixed extensions before the standardized CSS property
ERROR
  end
end
