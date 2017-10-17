require 'pre-commit/runner'

##
# The pre-commit gem.
#
module PreCommit

  # Can not delete this method with out a deprecation strategy.
  # It is refered to in the generated pre-commit hook in versions 0.0-0.1.1
  #
  # NOTE: The deprecation strategy *may* be just delete it since, we're still
  # pre 1.0.
  #
  # Actually, on the deprecation note. This method isn't really the problem.
  # The problem is the default generated pre-commit hook. It shouldn't have
  # logic in it. The we have freedom to change the gem implementation however
  # we want, and nobody is forced to update their pre-commit binary.
  def self.checks_to_run
    warn "WARNING: You are using old hook version, you can update it with: pre-commit install"
    runner.list_to_run(:checks)
  end

  def self.run
    runner.run or exit 1
  end

  def self.runner
    @runner ||= PreCommit::Runner.new
  end
end
