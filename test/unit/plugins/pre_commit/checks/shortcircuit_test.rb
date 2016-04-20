require 'minitest_helper'
require 'plugins/pre_commit/checks/short_circuit'

describe PreCommit::Checks::ShortCircuit do
  subject{ PreCommit::Checks::ShortCircuit.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    subject.call([]).must_equal nil
  end

  it "succeeds if only good changes" do
    subject.call([fixture_file('valid_file.rb')]).must_equal nil
  end

  it "fails if file contains true &&" do
    subject.call([fixture_file('shortcircuit_file.rb')]).to_a.must_equal([
      "Logical short circuit found:",
      "test/files/shortcircuit_file.rb:3:    if true && something",
      "test/files/shortcircuit_file.rb:7:    if false && something"
    ])
  end
end
