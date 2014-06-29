require 'minitest_helper'
require 'plugins/pre_commit/checks/debugger'

describe PreCommit::Checks::Debugger do
  subject{ PreCommit::Checks::Debugger.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    subject.call([]).must_equal nil
  end

  it "filters out Gemfiles files" do
    subject.files_filter([
      fixture_file('valid_file.rb'),fixture_file('Gemfiles'),fixture_file('console_log.rb')
    ]).must_equal([
      fixture_file('valid_file.rb'),fixture_file('console_log.rb')
    ])
  end

  it "succeeds if only good changes" do
    subject.call([fixture_file('valid_file.rb')]).must_equal nil
  end

  it "fails if file contains debugger" do
    subject.call([fixture_file('debugger_file.rb')]).must_equal(<<-EXPECTED)
debugger statement(s) found:
test/files/debugger_file.rb:3:  	debugger
EXPECTED
  end

  it "Skips checking the Gemfile" do
    files = [fixture_file("with_debugger/Gemfile")]
    subject.call(files).must_equal nil
  end

  it "Skips checking the Gemfile.lock" do
    files = [fixture_file("with_debugger/Gemfile.lock")]
    subject.call(files).must_equal nil
  end
end
