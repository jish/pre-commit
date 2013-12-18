require 'pluginator'
require 'pre-commit/utils'

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
    checks_to_run = `git config pre-commit.checks`.chomp.split(/,\s*/).map(&:to_sym)

    checks_to_run = [
      :white_space, :console_log, :debugger, :pry, :tabs, :jshint,
      :migrations, :merge_conflict, :local, :nb_space
    ] if checks_to_run.empty?

    checks_to_run.map! do |name|
      pluginator.first_class('checks', name) ||
      pluginator.first_ask('checks', 'supports', name) ||
      begin
        $stderr.puts "Could not find plugin supporting #{name}."
        nil
      end
    end
    checks_to_run.compact
  end

  def self.pluginator
    @pluginator ||= Pluginator.find('pre_commit', :extends => [:first_ask, :first_class] )
  end

  def self.run
    staged_files = Utils.staged_files
    errors = checks_to_run.map { |cmd| cmd.call(staged_files.dup) }.compact
    if errors.any?
      $stderr.puts "pre-commit: Stopping commit because of errors."
      $stderr.puts errors.join("\n")
      $stderr.puts
      $stderr.puts "pre-commit: You can bypass this check using `git commit -n`"
      $stderr.puts
      exit 1
    else
      exit 0
    end
  end
end
