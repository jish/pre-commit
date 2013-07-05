module PreCommit
  class PryCheck
    def self.call(staged_files)
      return if staged_files.empty?
      result = `#{Utils.grep} binding.pry #{staged_files.join(" ")}`.strip
      return unless $?.success?
      "binding.pry found:\n#{result}"
    end
  end
end
