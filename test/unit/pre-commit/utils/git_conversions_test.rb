require 'minitest_helper'
require 'pre-commit/utils/git_conversions'

describe PreCommit::Utils::GitConversions do
  subject do
    Object.new.send(:extend, PreCommit::Utils::GitConversions)
  end

  describe :str_symbolize do
    it "converts strings to symbols" do
      subject.str_symbolize(':simple').must_equal(:simple)
    end

    it "leaves symbols in place" do
      subject.str_symbolize(:simple).must_equal(:simple)
    end

    it "leaves strings in place" do
      subject.str_symbolize('simple').must_equal('simple')
    end
  end

  describe :str2arr do
    it "converts strings to arrays" do
      subject.str2arr("test, some,string").must_equal(%w{test some string})
    end

    it "str_symbolizes array values" do
      subject.str2arr(":test,:some, string").must_equal([:test, :some, "string"])
    end
  end

  describe :git_to_ruby do
    it "transforms arrays" do
      subject.git_to_ruby("[1,2,3]").must_equal(%w{1 2 3})
    end

    it "transforms empty string to nil" do
      subject.git_to_ruby("").must_equal(nil)
    end

    it "transforms string to symbols" do
      subject.git_to_ruby(":value").must_equal(:value)
    end

    it "transforms does not change strings" do
      subject.git_to_ruby("value").must_equal("value")
    end

    it "passes on unknowns" do
      subject.git_to_ruby({}).must_equal({})
    end
  end

  describe :sym_symbolize do
    it "converts symbols to strings" do
      subject.sym_symbolize(:something).must_equal(":something")
    end

    it "leaves strings in place" do
      subject.sym_symbolize("something").must_equal("something")
    end
  end

  describe :arr2str do
    it "converts arrays to strings" do
      subject.arr2str([:symbols, "strings"]).must_equal("[:symbols, strings]")
    end
  end

  describe :ruby_to_git do
    it "converts strings" do
      subject.ruby_to_git("something").must_equal("something")
    end
    it "converts symbols" do
      subject.ruby_to_git(:something).must_equal(":something")
    end
    it "converts arrays" do
      subject.ruby_to_git([:symbols, "strings"]).must_equal("[:symbols, strings]")
    end
  end

end
