module PreCommit
  module Checks
    class Migration
      def self.aliases
        [:migrations]
      end

      def call(staged_files)
        migration_files = migration_files(staged_files)
        schema_files = schema_files(staged_files)

        if migration_files.any? && schema_files.none?
          "It looks like you're adding a migration, but did not update the schema file"
        elsif migration_files.none? && schema_files.any?
          "You're trying to change the schema without adding a migration file"
        elsif migration_files.any? && schema_files.any?
          versions = migration_files.map { |f| f[/\d+/] }
          schema = schema_files.map { |f| File.read(f) }.join
          missing_versions = versions.select { |version| !schema.include?(version) }
          if missing_versions.any?
            "You did not add the schema versions for #{versions.join(', ')} to #{schema_files.join(' or ')}"
          end
        end
      end

      private

      def migration_files(staged_files)
        staged_files.grep(/db\/migrate\/.*\.rb/)
      end

      def schema_files(staged_files)
        staged_files.select { |f| File.basename(f) =~ /schema\.rb|structure.*\.sql/ }
      end

    end
  end
end
