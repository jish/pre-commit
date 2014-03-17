require 'minitest_helper'
require 'plugins/pre_commit/checks/checkstyle'

describe PreCommit::Checks::Checkstyle do
  let(:config) do
    mock = MiniTest::Mock.new
    mock.expect(:get, '', ['checkstyle.config'])
    mock.expect(:get, '', ['checkstyle.checks'])
    mock
  end
  let(:check) {PreCommit::Checks::Checkstyle.new(nil, config, [])}

  it "succeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds for good code" do
    check.call([fixture_file('good.java')]).must_equal nil
  end

  it "fails for bad formatted code" do
    file = File.expand_path(fixture_file("bad.java"))
    check.call([file]).must_equal <<-ERROR
Starting audit...
#{file}:1: Missing a Javadoc comment.
#{file}:1:1: Utility classes should not have a public or default constructor.
#{file}:2:3: Missing a Javadoc comment.
#{file}:2:27: Parameter args should be final.
Audit done.
ERROR
  end
end
