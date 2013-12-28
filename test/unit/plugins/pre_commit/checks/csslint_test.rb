require 'minitest_helper'
require 'plugins/pre_commit/checks/csslint'
require 'execjs'

describe PreCommit::Checks::Csslint do
  let(:check){ PreCommit::Checks::Csslint.new(nil, nil) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.run_check(test_filename('valid_file.css')).must_equal []
  end

  it "succeeds if only good changes" do
    check.call([test_filename('valid_file.css')]).must_equal nil
  end

  it "fails if file contains debugger" do
    check.run_check(test_filename('bad_file.css')).must_equal [
      {
        "type"=>"error", "line"=>3, "col"=>8, "message"=>"Expected RBRACKET at line 3, col 8.", "evidence"=>"  color:#cfc2b5",
        "rule"=>{"id"=>"errors", "name"=>"Parsing Errors", "desc"=>"This rule looks for recoverable syntax errors.", "browsers"=>"All"}
      }, {
        "type"=>"error", "line"=>3, "col"=>8, "message"=>"Expected RBRACKET at line 3, col 8.", "evidence"=>"  color:#cfc2b5",
        "rule"=>{"id"=>"errors", "name"=>"Parsing Errors", "desc"=>"This rule looks for recoverable syntax errors.", "browsers"=>"All"}
      }
    ]
  end

  it "formats errors" do
    data = {
      "type"=>"error", "line"=>3, "col"=>8, "message"=>"Expected RBRACKET at line 3, col 8.", "evidence"=>"  color:#cfc2b5",
      "rule"=>{"id"=>"errors", "name"=>"Parsing Errors", "desc"=>"This rule looks for recoverable syntax errors.", "browsers"=>"All"}
    }
    check.display_error(data, "test_file.css").must_equal("Expected RBRACKET at line 3, col 8.\ntest_file.css:4   color:#cfc2b5")
  end

  it "fails if file contains debugger" do
    check.call([test_filename('bad_file.css')]).must_equal "Expected RBRACKET at line 3, col 8.\ntest/files/bad_file.css:4   color:#cfc2b5\nExpected RBRACKET at line 3, col 8.\ntest/files/bad_file.css:4   color:#cfc2b5"
  end

end
