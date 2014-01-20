require 'minitest_helper'
require 'pre-commit/plugins_list'

class ClassBase
  def call(*args)
  end
end
class Class1 < ClassBase; end
class Class3 < ClassBase
  def self.includes
    [:class4]
  end
end
class Class4 < ClassBase; end
class Class5 < ClassBase
  def self.excludes
    [:class4]
  end
end
class Class6 < ClassBase
  def self.excludes
    [:class3]
  end
end
class Class7 < ClassBase
  def self.includes
    [:class6]
  end
end

describe PreCommit::PluginsList do
  describe :find_class do
    subject do
      PreCommit::PluginsList.new([], []) do |name|
        { :class1 => Class1 }[name]
      end
    end

    it "finds class" do
      subject.send(:find_class, :class1).must_equal(Class1)
    end

    it "does not find class" do
      subject.send(:find_class, :class2).must_equal(nil)
    end

  end

  describe :configured_names do
    subject do
      PreCommit::PluginsList.new([:a, :b], []) do |name|
      end
    end

    it "has configured_names" do
      subject.configured_names.must_equal([:a, :b])
    end
  end

  describe :finds_classes do
    subject do
      PreCommit::PluginsList.new([], []) do |name|
        { :class1 => Class1 }[name]
      end
    end

    it "finds existing class" do
      subject.send(:find_classes, [:class1]).must_equal([[:class1, Class1]])
    end

    it "does not find missing class" do
      subject.send(:find_classes, [:class2]).must_equal([])
    end

    it "finds only existing class" do
      subject.send(:find_classes, [:class1, :class2]).must_equal([[:class1, Class1]])
    end
  end

  describe :class_and_includes do
    subject do
      PreCommit::PluginsList.new([], []) do |name|
        { :class1 => Class1, :class3 => Class3, :class4 => Class4 }[name]
      end
    end

    it "finds no included class" do
      subject.send(:class_and_includes, :class1, Class1).must_equal([:class1, Class1, []])
    end

    it "finds included class" do
      subject.send(:class_and_includes, :class3, Class3).must_equal([:class3, Class3, [[:class4, Class4,[]]]])
    end
  end

  describe :find_classes_and_includes do
    subject do
      PreCommit::PluginsList.new([], []) do |name|
        { :class1 => Class1, :class3 => Class3, :class4 => Class4 }[name]
      end
    end

    it "finds existing class" do
      subject.send(:find_classes_and_includes, [:class1]).must_equal([[:class1, Class1, []]])
    end

    it "does not find missing class" do
      subject.send(:find_classes_and_includes, [:class2]).must_equal([])
    end

    it "finds nested existing class" do
      subject.send(:find_classes_and_includes, [:class1, :class2, :class3]).must_equal([[:class1, Class1, []], [:class3, Class3, [[:class4, Class4,[]]]]])
    end
  end

  describe :excludes do
    subject do
      PreCommit::PluginsList.new([], []) do |name|
      end
    end

    it "does not exclude classes" do
      subject.send(:excludes, [[:class1, Class1, []]]).must_equal([[]])
    end

    it "does exclude classes" do
      subject.send(:excludes, [[:class5, Class5, []]]).must_equal([[:class4]])
    end

    it "does exclude nested classes" do
      subject.send(:excludes, [[:class7, Class7, [[:class6, Class6, []]]]]).must_equal([[[:class3]]])
    end
  end

  describe :filter_excludes do
    subject do
      PreCommit::PluginsList.new([], []) do |name|
      end
    end

    it "does not filter classes" do
      subject.send(:filter_excludes, [[:class1, Class1, []]], []).must_equal([[:class1, Class1, []]])
    end

    it "does filter classes" do
      subject.send(:filter_excludes, [[:class1, Class1, []]], [:class1]).must_equal([])
    end

    it "does filter nested classes" do
      subject.send(:filter_excludes, [[:class3, Class3, [[:class4, Class4, []]]]], [:class4]).must_equal([[:class3, Class3, []]])
    end

    it "does filter including classes" do
      subject.send(:filter_excludes, [[:class3, Class3, [[:class4, Class4, []]]]], [:class3]).must_equal([])
    end
  end

  describe :evaluated_names_pairs do
    subject do
      PreCommit::PluginsList.new([:class1, :class2, :class3, :class7], []) do |name|
        { :class1 => Class1, :class3 => Class3, :class4 => Class4, :class6 => Class6, :class7 => Class7 }[name]
      end
    end

    it "evaluates list" do
      subject.send(:evaluated_names_pairs).must_equal([[:class1, Class1, []], [:class7, Class7, [[:class6, Class6, []]]]])
    end

    it "evaluated_names" do
      subject.evaluated_names.must_equal([:class1, :class7, :class6])
    end

    it "list_to_run" do
      subject.list_to_run.must_equal([Class1, Class7, Class6])
    end
  end

  describe "evaluated_names_pairs config remove" do
    subject do
      PreCommit::PluginsList.new([:class7], [:class6]) do |name|
        { :class1 => Class1, :class3 => Class3, :class4 => Class4, :class6 => Class6, :class7 => Class7 }[name]
      end
    end

    it "evaluates list" do
      subject.send(:evaluated_names_pairs).must_equal([[:class7, Class7, []]])
    end

  end


end
