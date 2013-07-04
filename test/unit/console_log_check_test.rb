require 'minitest_helper'
require 'pre-commit/checks/console_log_check'

describe PreCommit::ConsoleLogCheck do
  let(:check){ PreCommit::ConsoleLogCheck }

  it "succeeds if nothing changed" do
    check.run([]).must_equal nil
  end

  it "succeeds with valid .js file changed" do
    check.run([test_filename('valid_file.js')]).must_equal nil
  end

  it "succeeds if non js files has console.log" do
    check.run([test_filename('changelog.md')]).must_equal nil
  end

  it "fails if a js file has a console.log" do
    check.run([test_filename('console_log.js')]).must_equal "console.log found:\ntest/files/console_log.js:6:    console.log(\"I'm in bar\");"
  end
end
