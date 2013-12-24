require 'open3'

module PreCommit
  module Checks
    class Coffeelint
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
