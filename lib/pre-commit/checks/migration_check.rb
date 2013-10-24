module PreCommit
  class MigrationCheck
    class << self
      def call(staged_files)
        migration_present = migration_file_present?(staged_files)
        schema_change = schema_file_present?(staged_files)

        if migration_present && !schema_change
          "It looks like you're adding a migration, but did not update the schema file"
        elsif schema_change && !migration_present
          "You're trying to change the schema without adding a migration file"
        end
      end

      private

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
    end
  end
end
