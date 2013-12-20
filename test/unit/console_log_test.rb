require 'minitest_helper'
require 'plugins/pre_commit/checks/console_log'

describe PreCommit::Checks::ConsoleLog do
  let(:check){ PreCommit::Checks::ConsoleLog }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds with valid .js file changed" do
    check.call([test_filename('valid_file.js')]).must_equal nil
  end

  it "succeeds if non js files has console.log" do
    check.call([test_filename('changelog.md')]).must_equal nil
  end

  it "fails if a js file has a console.log" do
    check.call([test_filename('console_log.js')]).must_equal "console.log found:\ntest/files/console_log.js:6:    console.log(\"I'm in bar\");"
  end
end
