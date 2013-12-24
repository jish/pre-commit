require 'minitest_helper'
require 'pre-commit/utils/string_to_ruby'

describe PreCommit::Utils::StringToRuby do
  subject do
    Object.new.send(:extend, PreCommit::Utils::StringToRuby)
  end

  describe :symbolize do
    it "converts strings to symbols" do
      subject.symbolize(':simple').must_equal(:simple)
    end

    it "leaves symbols in place" do
      subject.symbolize(:simple).must_equal(:simple)
    end

    it "leaves strings in place" do
      subject.symbolize('simple').must_equal('simple')
    end
  end

  describe :str2arr do
    it "converts strings to arrays" do
      subject.str2arr("test, some,string").must_equal(%w{test some string})
    end

    it "symbolizes array values" do
      subject.str2arr(":test,:some, string").must_equal([:test, :some, "string"])
    end
  end

  describe :string_to_ruby do
    it "transforms arrays" do
      subject.string_to_ruby("[1,2,3]").must_equal(%w{1 2 3})
    end

    it "transforms empty string to nil" do
      subject.string_to_ruby("").must_equal(nil)
    end

    it "transforms string to symbols" do
      subject.string_to_ruby(":value").must_equal(:value)
    end

    it "transforms does not change strings" do
      subject.string_to_ruby("value").must_equal("value")
    end

    it "passes on unknowns" do
      subject.string_to_ruby({}).must_equal({})
    end
  end
end
