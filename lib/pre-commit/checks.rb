require 'pluginator'
require 'pre-commit/utils'

module PreCommit

  DEFAULT_CHECKS = [
    :white_space, :console_log, :debugger, :pry, :tabs, :jshint,
    :migrations, :merge_conflict, :local, :nb_space
  ]

  DEFAULT_WARNINGS = []

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
    @checks_to_run ||= find_plugins(configured_checks)
  end

  def self.warnings_to_run
    @warnings_to_run ||= find_plugins(configured_warnings)
  end

  def self.configured_checks
    @configured_checks   ||= get_git_config('checks',   DEFAULT_CHECKS)
  end

  def self.configured_warnings
    @configured_warnings ||= get_git_config('warnings', DEFAULT_WARNINGS)
  end

  def self.get_git_config(name, default)
    array_or_default(
      `git config pre-commit.#{name}`.chomp.split(/,\s*/).map(&:to_sym),
      default
    )
  end

  def self.array_or_default(list, default)
    list = default if list.nil? || list.empty?
    list
  end

  def self.find_plugins(names)
    names.map{|name| find_plugin(name) }.compact
  end

  def self.find_plugin(name)
    pluginator.first_class('checks', name) ||
    pluginator.first_ask('checks', 'supports', name) ||
    begin
      $stderr.puts "Could not find plugin supporting #{name}."
      nil
    end
  end

  def self.pluginator
    @pluginator ||= Pluginator.find('pre_commit', :extends => [:first_ask, :first_class] )
  end

  def self.execute_list(list)
    list.map { |cmd| cmd.call(@staged_files.dup) }.compact
  end

  def self.run
    @staged_files = Utils.staged_files
    show_warnings( execute_list(warnings_to_run) )
    show_errors(   execute_list(checks_to_run  ) )
  end

  def self.show_warnings(warnings)
    if warnings.any?
       $stderr.puts "pre-commit: Some warnings were raised. These will not stop commit:"
       $stderr.puts warnings.join("\n")
    end
  end

  def self.show_errors(errors)
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
