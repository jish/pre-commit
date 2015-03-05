require 'minitest_helper'
require 'plugins/pre_commit/checks/byebug'

describe PreCommit::Checks::Byebug do
  subject{ PreCommit::Checks::Byebug.new(nil, nil, []) }

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

  it "fails if file contains byebug" do
    subject.call([fixture_file('byebug_file.rb')]).to_a.must_equal([
                                                                         "byebug statement(s) found:",
                                                                         "test/files/byebug_file.rb:3:    byebug"
                                                                     ])
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
