require 'open3'

require 'pre-commit/checks/shell'
require 'pre-commit/error_list'
require 'pre-commit/line'

module PreCommit
  module Checks
    class Grep < Shell
      def initialize(*)
        super

        @extra_grep = nil
        @message = nil
        @pattern = nil
      end

      class PaternNotSet < StandardError
        def message
          "Please define 'pattern' method."
        end
      end

    # overwrite those:

      def files_filter(staged_files)
        staged_files
      end

      def extra_grep
        @extra_grep or []
      end

      def message
        @message or ""
      end

      def pattern
        @pattern or raise PaternNotSet.new
      end

      def extra_pattern
        @extra_pattern
      end

    # general code:

      def call(staged_files)
        staged_files = files_filter(staged_files)
        return if staged_files.empty?

        result =
        in_groups(staged_files).map do |files|
          args = grep + [pattern] + files
          args += ["|", "grep"] + extra_grep if !extra_grep.nil? and !extra_grep.empty?

          results = [
            execute(args, success_status: false),
            extra_execute(files)
          ].compact

          results.empty? ? nil : results.join('')
        end.compact

        result.empty? ? nil : parse_errors(message, result)
      end

    private

      def parse_errors(message, list)
        result = PreCommit::ErrorList.new(message)
        result.errors +=
        list.map do |group|
          group.split(/\n/)
        end.flatten.compact.map do |line|
          PreCommit::Line.new(nil, *parse_error(line))
        end
        result
      end

      def parse_error(line)
        matches = /^([^:]+):([[:digit:]]+):(.*)$/.match(line)
        matches and matches.captures
      end

      def grep(grep_version = nil)
        grep_version ||= detect_grep_version
        if grep_version =~ /FreeBSD/
          %w{grep -EnIH}
        else
          %w{grep -PnIH}
        end
      end

      def detect_grep_version
        Open3.popen3('grep', '--version') do |_, stdout, _|
          return '' if stdout.eof?

          first_line = stdout.readline
          return first_line.sub(/^[^0-9.]*\([0-9.]*\)$/, '\1')
        end
      end

      def extra_execute(files)
        return nil if extra_pattern.nil? or extra_pattern.empty?
        args = grep + [extra_pattern] + files

        execute(args, success_status: false)
      end

    end
  end
end
