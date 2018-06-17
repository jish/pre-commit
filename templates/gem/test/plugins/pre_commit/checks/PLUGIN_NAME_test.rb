=begin
Copyright <%= copyright %>

See the file LICENSE for copying permission.
=end

require 'minitest_helper'
require 'plugins/pre_commit/checks/<%= name %>'

describe PreCommit::Checks::<%= name.capitalize %> do
  let(:check){ PreCommit::Checks::<%= name.capitalize %>.new(nil, nil, []) }

  it "does nothing" do
    check.send(:run_check, "rake").must_be_nil
  end

  it "checks files" do
    Dir.chdir(test_files) do
      # TODO: create example files in test/files
      check.send(:run_check, ".keep").must_be_nil
    end
  end

end
