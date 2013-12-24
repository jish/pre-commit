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

  describe "stubbed - failing" do
    before do
      @output = StringIO.new
    end
    subject do
      PreCommit::Runner.new(
        @output,
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
        subject.show_output(:checks, []).must_equal(true)
        @output.string.must_equal('')
      end
      it "shows output" do
        subject.show_output(:checks, ["result 1", "result 2"]).must_equal(false)
        @output.string.must_match(/^result 1$/)
        @output.string.must_match(/^result 2$/)
      end
    end

    describe :run do
      it "has no errors" do
        subject.run.must_equal(false)
        @output.string.must_equal(<<-EXPECTED)
pre-commit: Some warnings were raised. These will not stop commit:
result 1
pre-commit: Stopping commit because of errors.
result 2
result 3

pre-commit: You can bypass this check using `git commit -n`

EXPECTED
      end
    end

  end

  describe "stubbed - success" do
    before do
      @output = StringIO.new
    end
    subject do
      PreCommit::Runner.new(
        @output,
        [],
        FakeAll.new(
          :warnings => [:plugin1],
          :checks   => [:plugin2, :plugin3],
        ),
        FakeAll.new(
          :plugin1 => FakeAll.new(nil),
          :plugin2 => FakeAll.new(nil),
          :plugin3 => FakeAll.new(nil),
        ),
      )
    end
    it "has no errors" do
      subject.run.must_equal(true)
      @output.string.must_equal('')
    end
  end

  describe "real run" do
    before do
      @output = StringIO.new
      create_temp_dir
      start_git
    end
    after(&:destroy_temp_dir)

    it "detects tabs" do
      write("test.rb", "\t\t Muahaha\n\n\n")
      sh "git add -A"
      status = PreCommit::Runner.new(@output, ["test.rb"]).run
      @output.string.must_equal(<<-EXPECTED)
pre-commit: Stopping commit because of errors.
test.rb:2: new blank line at EOF.

detected tab before initial space:
test.rb:1:\t\t Muahaha

pre-commit: You can bypass this check using `git commit -n`

EXPECTED
      status.must_equal(false) # more interested in output first
    end

    it "allows commit" do
      status = PreCommit::Runner.new(@output).run
      @output.string.must_equal('')
      status.must_equal(true) # more interested in output first
    end

  end

end
