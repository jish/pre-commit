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

  it "fails if file contains true ||" do
    subject.call([fixture_file('shortcircuit_file.rb')]).to_a.must_include(
      "test/files/shortcircuit_file.rb:3:    if false && something"
    )
  end

  it "fails if file contains true ||" do
    subject.call([fixture_file('shortcircuit_file.rb')]).to_a.must_include(
      "test/files/shortcircuit_file.rb:7:    if true || something"
    )
  end

  it "fails if file contains false &&" do
    subject.call([fixture_file('shortcircuit_file.rb')]).to_a.must_include(
      "test/files/shortcircuit_file.rb:3:    if false && something"
    )
  end

  it "includes the error description" do
    subject.call([fixture_file('shortcircuit_file.rb')]).to_a.must_include(
      "Logical short circuit found:"
    )
  end

  # Daft but not 'wrong'
  it "succeeds if file contains false ||" do
    subject.call([fixture_file('shortcircuit_file.rb')]).to_a.wont_include(
      "test/files/shortcircuit_file.rb:12:    if false || something"
    )
  end

  it "succeeds if file contains true &&" do
    subject.call([fixture_file('shortcircuit_file.rb')]).to_a.wont_include(
      "test/files/shortcircuit_file.rb:16:    if true && something"
    )
  end

  it "succeeds if file contains true" do
    subject.call([fixture_file('shortcircuit_file.rb')]).to_a.wont_include(
      "test/files/shortcircuit_file.rb:20:    if true"
    )
  end
end
