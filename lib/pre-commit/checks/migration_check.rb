class PreCommit
  class MigrationCheck

    attr_accessor :error_message

    def call
      staged_files = load_staged_files
      run(staged_files)

      if !passed? && error_message
        $stderr.puts "pre-commit: #{error_message}"
      end

      passed?
    end

    def run(staged_files)
      migration_present = migration_file_present?(staged_files)
      schema_change = schema_file_present?(staged_files)

      if migration_present && !schema_change
        @error_message = "It looks like you're adding a migration, but did not update the schema file"
        @passed = false
      elsif schema_change && !migration_present
        @error_message = "You're trying to change the schema without adding a migraiton file"
        @passed = false
      else
        @passed = true
      end
    end

    def migration_file_present?(staged_files)
      staged_files.any? { |file| file =~ /db\/migrate\/.*\.rb/ }
    end

    def schema_file_present?(staged_files)
      staged_files.any? do |file|
        basename = File.basename(file)

        [/schema\.rb/i, /structure.*\.sql/].any? do |regex|
          basename =~ regex
        end
      end
    end

    def passed?
      @passed
    end

    def load_staged_files
      Utils.staged_files('.').split(" ")
    end

  end
end
