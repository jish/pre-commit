require 'minitest_helper'
require 'plugins/pre_commit/checks/jshint'
require 'execjs'

describe PreCommit::Checks::Jshint do
  let(:check){ PreCommit::Checks::Jshint.new(nil, nil) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.run_check(test_filename('valid_file.js')).must_equal []
  end

  it "succeeds if only good changes" do
    check.call([test_filename('valid_file.js')]).must_equal nil
  end

  it "fails if file contains debugger" do
    check.run_check(test_filename('bad_file.js')).must_equal [{
      "id"=>"(error)", "raw"=>"Missing semicolon.", "evidence"=>"}", "line"=>4, "character"=>2, "reason"=>"Missing semicolon."
    }]
  end

  it "fails if file contains debugger" do
    check.call([test_filename('bad_file.js')]).must_equal "Missing semicolon.\ntest/files/bad_file.js:5 }"
  end

  describe "filesystem" do
    before do
      @example = File.join(Dir.pwd, test_filename('bad_file.js'))
      create_temp_dir
      start_git
    end
    after(&:destroy_temp_dir)

    it "uses proper config file" do
      File.open(".jshintrc", "w") do |file|
        file.write <<-CONFIG
{
  "asi": true,
  "lastsemic": true
}
CONFIG
      end
      check.run_check(@example).must_equal []
    end

    it "does not use broken config file" do
      File.open(".jshintrc", "w") do |file|
        file.write <<-CONFIG
{
  "asi": true,
  "lastsemic": true
}
}
CONFIG
      end
      ->(){ check.call([@example]) }.must_raise ExecJS::RuntimeError
    end

  end
end
