require 'minitest_helper'
require 'plugins/pre_commit/checks/console_log'

describe PreCommit::Checks::ConsoleLog do
  subject do
    PreCommit::Checks::ConsoleLog.new(nil, nil, [])
  end

  it "filters out js files" do
    subject.files_filter([
      fixture_file('valid_file.js'),fixture_file('changelog.md'),fixture_file('console_log.js')
    ]).must_equal([
      fixture_file('valid_file.js'),fixture_file('console_log.js')
    ])
  end

  it "succeeds if nothing changed" do
    subject.call([]).must_equal nil
  end

  it "succeeds with valid .js file changed" do
    subject.call([fixture_file('valid_file.js')]).must_equal nil
  end

  it "succeeds if non js files has console.log" do
    subject.call([fixture_file('changelog.md')]).must_equal nil
  end

  it "fails if a js file has a console.log" do
    subject.call([fixture_file('console_log.js')]).to_a.must_equal([
      "console.log found:",
      "test/files/console_log.js:6:    console.log(\"I'm in bar\");"
    ])
  end
end
