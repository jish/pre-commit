# encoding: utf-8
require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class NbSpace < Plugin

      def call(staged_files)
        nb_space = " "
        raise "you messed that up" unless nb_space.bytes.to_a == [194, 160]

        staged_files.reject! { |f| f =~ /^vendor\// || !File.read(f, encoding: 'utf-8').include?(nb_space) }

        bad = staged_files.map do |file|
          content = File.read(file).lines.to_a
          line_no = content.index { |l| l.include?(nb_space) }
          char_no = content[line_no].index(nb_space)
          [file, line_no, char_no]
        end

        return if bad.empty?
        "Detected non-breaking space in #{bad.map { |f,l,c| "#{f}:#{l+1} character:#{c+1}" }.join(" and")}, remove it!"
      end

      def self.description
        "Detected non-breaking spaces 194, 160."
      end

    end
  end
end
