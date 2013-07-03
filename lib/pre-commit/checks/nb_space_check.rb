# encoding: utf-8
require 'pre-commit/utils'

module PreCommit
  class NbSpaceCheck

    attr_accessor :error_message

    def self.call(quiet=false)
      check = new
      result = check.run(Utils.staged_files(".").split(" "))
      puts check.error_message if !result && !quiet
      result
    end

    def run(staged_files)
      nb_space = " "
      raise "you messed that up" unless nb_space.bytes.to_a == [194, 160]

      staged_files.reject! { |f| f =~ /^vendor\// || !File.read(f).include?(nb_space) }

      bad = staged_files.map do |file|
        content = File.read(file).lines.to_a
        line_no = content.index { |l| l.include?(nb_space) }
        char_no = content[line_no].index(nb_space)
        [file, line_no, char_no]
      end

      if bad.empty?
        true
      else
        self.error_message = "Detected non-breaking space in #{bad.map { |f,l,c| "#{f}:#{l+1} character:#{c+1}" }.join(" and")}, remove it!"
        false
      end
    end

  end
end
