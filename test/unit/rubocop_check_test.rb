require 'minitest_helper'
begin
  require 'pre-commit/checks/rubocop_check'
rescue LoadError
  puts "Not running rubocop test"
else
  describe PreCommit::RubocopCheck do
    let(:check){ PreCommit::RubocopCheck }

    it "succeeds if nothing changed" do
      check.run([]).must_equal nil
    end

    it "succeeds if only good changes" do
      check.run([test_filename('valid_file.rb')]).must_equal nil
    end

    it "fails if file contains pry" do
      check.run([test_filename('merge_conflict.rb')]).must_include "1 file inspected, \e[31m2 offences detected\e[0m"
    end
  end
end
