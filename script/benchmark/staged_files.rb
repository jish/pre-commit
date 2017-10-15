require 'benchmark/ips'
require 'pre-commit/utils/staged_files'

class Subject
  include PreCommit::Utils::StagedFiles

  def filter_files1(files)
    first_pass = files
      .reject { |file| repo_ignored?(file) }
      .reject { |file| ignore_extension?(file) }
      .reject { |file| File.directory?(file) }
      .select { |file| File.exists?(file) }

    # If it's a source file, definitely check it.
    # Otherwise, attempt to guess if the file is binary or not.
    first_pass.select do |file|
      source_file?(file) || !appears_binary?(file)
    end
  end

  def filter_files2(files)
    first_pass = files.lazy
      .reject { |file| repo_ignored?(file) }
      .reject { |file| ignore_extension?(file) }
      .reject { |file| File.directory?(file) }
      .select { |file| File.exists?(file) }

    # If it's a source file, definitely check it.
    # Otherwise, attempt to guess if the file is binary or not.
    first_pass.select do |file|
      source_file?(file) || !appears_binary?(file)
    end
  end

  def filter_files3(files)
    first_pass = files.reject do |file|
      repo_ignored?(file) ||
      ignore_extension?(file) ||
      File.directory?(file) ||
      !File.exists?(file)
    end

    # If it's a source file, definitely check it.
    # Otherwise, attempt to guess if the file is binary or not.
    first_pass.select do |file|
      source_file?(file) || !appears_binary?(file)
    end
  end
end

files = Dir['lib/**/*']
subject = Subject.new

Benchmark.ips do |x|
  x.report('filter files 1') { subject.filter_files1(files) }
  x.report('filter files 2') { subject.filter_files2(files).to_a }
  x.report('filter files 3') { subject.filter_files3(files) }

  x.compare!
end
