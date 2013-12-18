require 'minitest_helper'
require 'plugins/pre-commit/checks/rubocop_check'



  describe PreCommit::RubocopCheck do
    let(:check){ PreCommit::RubocopCheck }

    it "succeeds if nothing changed" do
      check.call([]).must_equal nil
    end

    it "succeeds if only good changes" do
      check.call([test_filename('valid_file.rb')]).must_equal nil
    end

    it "fails if file contains errors" do
      # rubinius finds only 1 offense, all others find 2
      check.call([test_filename('merge_conflict.rb')]).must_match /1 file inspected, \e\[31m[12] offences? detected\e\[0m/
    end
  end if PreCommit.const_defined?('RubocopCheck')

