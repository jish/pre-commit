require 'minitest_helper'
require 'plugins/pre-commit/checks/ruby_symbol_hashrockets'

describe PreCommit::RubySymbolHashrockets do
  let(:check){ PreCommit::RubySymbolHashrockets }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds with valid" do
    check.call([test_filename('valid_hashrockets.rb')]).must_equal nil
  end

  it "fails with invalid" do
    result = check.call([test_filename('wrong_hashrockets.rb')])
    result.must_include "detected :symbol => value hashrocket:\n"
    result.must_include "test/files/wrong_hashrockets.rb:3:gem 'foo', :ref => 'v2.6.0'"
    result.lines.to_a.size.must_equal 9
  end
end
