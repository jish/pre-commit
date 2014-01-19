require 'minitest_helper'
require 'plugins/pre_commit/checks/console_log'

describe PreCommit::Checks::ConsoleLog do
  subject do
    PreCommit::Checks::ConsoleLog.new(nil, nil, [])
  end

  it "filters out js files" do
    subject.files_filter([
      test_filename('valid_file.js'),test_filename('changelog.md'),test_filename('console_log.js')
    ]).must_equal([
      test_filename('valid_file.js'),test_filename('console_log.js')
    ])
  end

  it "succeeds if nothing changed" do
    subject.call([]).must_equal nil
  end

  it "succeeds with valid .js file changed" do
    subject.call([test_filename('valid_file.js')]).must_equal nil
  end

  it "succeeds if non js files has console.log" do
    subject.call([test_filename('changelog.md')]).must_equal nil
  end

  it "fails if a js file has a console.log" do
    subject.call([test_filename('console_log.js')]).must_equal(<<-EXPECTED)
console.log found:
test/files/console_log.js:6:    console.log(\"I'm in bar\");
EXPECTED
  end
end
