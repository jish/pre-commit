require 'minitest_helper'
require 'plugins/pre_commit/checks/debugger'

describe PreCommit::Checks::Debugger do
  subject{ PreCommit::Checks::Debugger.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    subject.call([]).must_equal nil
  end

  it "filters out Gemfiles files" do
    subject.files_filter([
      test_filename('valid_file.rb'),test_filename('Gemfiles'),test_filename('console_log.rb')
    ]).must_equal([
      test_filename('valid_file.rb'),test_filename('console_log.rb')
    ])
  end

  it "succeeds if only good changes" do
    subject.call([test_filename('valid_file.rb')]).must_equal nil
  end

  it "fails if file contains debugger" do
    subject.call([test_filename('debugger_file.rb')]).must_equal(<<-EXPECTED)
debugger statement(s) found:
test/files/debugger_file.rb:3:    debugger
EXPECTED
  end

  it "Skips checking the Gemfile" do
    files = [test_filename("with_debugger/Gemfile")]
    subject.call(files).must_equal nil
  end

  it "Skips checking the Gemfile.lock" do
    files = [test_filename("with_debugger/Gemfile.lock")]
    subject.call(files).must_equal nil
  end
end
