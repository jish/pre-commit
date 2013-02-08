require File.expand_path('../../minitest_helper', __FILE__)
require 'pre-commit/cli'

class CliTest < MiniTest::Unit::TestCase

  def test_positive_answers
    cli = PreCommit::Cli.new
    assert cli.answered_yes?("y\n")
    assert cli.answered_yes?("Y\n")
    assert cli.answered_yes?("\n")
  end

  def test_negative_answers
    cli = PreCommit::Cli.new
    assert !cli.answered_yes?("n\n")
    assert !cli.answered_yes?("N\n")
    assert !cli.answered_yes?("j\n")
  end

end
