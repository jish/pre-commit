require 'minitest_helper'
require 'plugins/pre-commit/checks/nb_space_check'

describe PreCommit::NbSpaceCheck do
  let(:check){ PreCommit::NbSpaceCheck }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([test_filename("pre-commit.rb")]).must_equal nil
  end

  it "fails if script fails" do
    check.call([test_filename("file_with_nb_space.rb")]).must_equal "Detected non-breaking space in test/files/file_with_nb_space.rb:2 character:13, remove it!"
  end
end
