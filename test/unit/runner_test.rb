require 'minitest_helper'
require 'pre-commit/runner'
require 'stringio'

class FakeAll
  def initialize(value)
    @value = value
  end
  def get_combined(name)
    @value[name]
  end
  def find_check(name)
    @value[name]
  end
  def call(list)
    @value
  end
end

describe PreCommit::Runner do
  before do
    @output = StringIO.new
  end
  subject do
    PreCommit::Runner.new(
      [],
      FakeAll.new(
        :warnings => [:plugin1],
        :checks   => [:plugin2, :plugin3],
      ),
      FakeAll.new(
        :plugin1 => FakeAll.new("result 1"),
        :plugin2 => FakeAll.new("result 2"),
        :plugin3 => FakeAll.new("result 3"),
      ),
      @output
    )
  end

  it "has warning template" do
    result = subject.warnings(["warn 1", "warn 2"])
    result.must_match(/^pre-commit:/)
    result.must_match(/^warn 1$/)
    result.must_match(/^warn 2$/)
    result.wont_match(/^error 3$/)
  end

  it "has errors template" do
    result = subject.checks(["error 3", "error 4"])
    result.must_match(/^pre-commit:/)
    result.must_match(/^error 3$/)
    result.must_match(/^error 4$/)
    result.wont_match(/^warn 1$/)
  end

  it "finds plugins" do
    result = subject.list_to_run(:checks).map(&:class)
    result.size.must_equal(2)
    result.must_include(FakeAll)
  end

  it "executes checks" do
    result = subject.execute([FakeAll.new("result 1"), FakeAll.new("result 2")])
    result.size.must_equal(2)
    result.must_include("result 1")
    result.must_include("result 2")
    result.wont_include("result 3")
  end

  describe :show_output do
    it "has no output" do
      subject.show_output(:checks, [])
      @output.string.must_equal('')
    end
    it "shows output" do
      subject.show_output(:checks, ["result 1", "result 2"])
      @output.string.must_match(/^result 1$/)
      @output.string.must_match(/^result 2$/)
    end
  end

end
