require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Migration < Plugin
      VERSION_PATTERN = /(\d{4}_?\d{2}_?\d{2}_?\d{6})/

      VersionedFile = Struct.new(:file, :version)

      def self.aliases
        [:migrations]
      end

      def call(staged_files)
        migration_files = versioned_migration_files(staged_files)
        schema_files = versioned_schema_files(staged_files)

        if migration_files.any? && schema_files.none?
          "It looks like you're adding a migration, but did not update the schema file"
        elsif migration_files.none? && schema_files.any?
          "You're trying to change the schema without adding a migration file"
        elsif migration_files.any? && schema_files.any?
          migration_versions = migration_files.map(&:version)
          schema_versions = schema_files.map(&:version)
          missing_versions = migration_versions - schema_versions

          if missing_versions.any?
            "You did not add the schema versions for "\
            "#{migration_versions.join(', ')} to #{schema_files.map(&:file).join(' or ')}"
          end
        end
      end

      private

      def versioned_migration_files(staged_files)
        files = staged_files.grep(/db\/migrate\/.*\.rb/)

        files.each_with_object([]) do |f, result|
          if f =~ VERSION_PATTERN
            result << VersionedFile.new(f, $1)
          end
        end
      end

      def versioned_schema_files(staged_files)
        files = staged_files.select do |f|
          File.basename(f) =~ /schema\.rb|structure.*\.sql/
        end

        files.each_with_object([]) do |f, result|
          File.read(f).scan(VERSION_PATTERN) do |i|
            version = i.first.gsub(/_/, "")
            result << VersionedFile.new(f, version)
          end
        end
      end

      def self.description
        "Detects rails database migrations and schema incompatibilities."
      end

    end
  end
end
