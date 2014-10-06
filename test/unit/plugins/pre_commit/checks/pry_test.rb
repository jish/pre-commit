require 'minitest_helper'
require 'plugins/pre_commit/checks/pry'

describe PreCommit::Checks::Pry do
  let(:check){ PreCommit::Checks::Pry.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([fixture_file('valid_file.rb')]).must_equal nil
  end

  it "fails if file contains pry" do
    check.call([fixture_file('pry_file.rb')]).to_a.must_equal([
      "binding.pry found:",
      "test/files/pry_file.rb:3:    binding.pry"
    ])
  end
end
