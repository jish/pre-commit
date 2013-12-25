require 'open3'
require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Coffeelint < Plugin
      def call(staged_files)
        staged_files = staged_files.grep(/\.coffee$/)
        return if staged_files.empty?

        args = staged_files.join(' ')

        stdout, stderr, result = Open3.capture3("coffeelint #{args}")
        stdout + stderr unless result.success?
      end
    end
  end
end
