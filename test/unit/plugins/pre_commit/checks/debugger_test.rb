require 'minitest_helper'
require 'plugins/pre_commit/checks/debugger'

describe PreCommit::Checks::Debugger do
  subject{ PreCommit::Checks::Debugger.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    subject.call([]).must_be_nil
  end

  it "filters out Gemfiles files" do
    subject.files_filter([
      fixture_file('valid_file.rb'),
      fixture_file('Gemfiles'),
      fixture_file('console_log.rb')
    ]).must_equal([
      fixture_file('valid_file.rb'),fixture_file('console_log.rb')
    ])
  end

  it "succeeds if only good changes" do
    subject.call([fixture_file('valid_file.rb')]).must_be_nil
  end

  it "fails if file contains debugger" do
    subject.call([fixture_file('debugger_file.rb')]).to_a.must_equal([
      "debugger statement(s) found:",
      "test/files/debugger_file.rb:3:  \tdebugger"
    ])
  end

  it "fails if file contains a byebug statement" do
    actual = subject.call([fixture_file("byebug_file.rb")]).to_a
    expected = [
      "debugger statement(s) found:",
      "test/files/byebug_file.rb:3:    byebug"
    ]
    actual.must_equal expected, "Did not detect byebug in byebug_file.rb"
  end

  it "Skips checking the Gemfile" do
    files = [fixture_file("with_debugger/Gemfile")]
    subject.call(files).must_be_nil
  end

  it "Skips checking the Gemfile.lock" do
    files = [fixture_file("with_debugger/Gemfile.lock")]
    subject.call(files).must_be_nil
  end
end
