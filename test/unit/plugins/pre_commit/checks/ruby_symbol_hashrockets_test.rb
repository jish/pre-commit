require 'minitest_helper'
require 'plugins/pre_commit/checks/ruby_symbol_hashrockets'

describe PreCommit::Checks::RubySymbolHashrockets do
  let(:check){ PreCommit::Checks::RubySymbolHashrockets.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds with valid" do
    check.call([fixture_file('valid_hashrockets.rb')]).must_equal nil
  end

  it "fails with invalid" do
    result = check.call([fixture_file('wrong_hashrockets.rb')]).must_equal(<<-EXPECTED)
detected :symbol => value hashrocket:
test/files/wrong_hashrockets.rb:3:gem 'foo', :ref => 'v2.6.0'
test/files/wrong_hashrockets.rb:5:{ :@test => \"foo_bar\" }
test/files/wrong_hashrockets.rb:6:{ :_test => \"foo_bar\" }
test/files/wrong_hashrockets.rb:7:{ :$test => \"foo_bar\" }
test/files/wrong_hashrockets.rb:8:{ :test! => \"foo_bar\" }
test/files/wrong_hashrockets.rb:9:{ :test? => \"foo_bar\" }
test/files/wrong_hashrockets.rb:10:{ :test= => \"foo_bar\" }
test/files/wrong_hashrockets.rb:11:{ :@@test => \"foo_bar\" }
EXPECTED
  end
end
