require 'minitest_helper'
require 'pre-commit/checks/migration_check'

describe PreCommit::MigrationCheck do
  let(:check) { PreCommit::MigrationCheck }

  it "succeeds if there is no change" do
    check.run([]).must_equal nil
  end

  it "succeeds if there is a migration and a schema change" do
    check.run(['db/migrate/01_foo.rb', 'db/schema.rb']).must_equal nil
  end

  it "succeeds if there is a migration and a sql schema change" do
    check.run(['db/migrate/01_foo.rb', 'db/foo_structure.sql']).must_equal nil
  end

  it "succeeds if random files are changed" do
    check.run(['public/javascript/foo.js', 'lib/bar.rb']).must_equal nil
  end

  it "fails if schema change is missing" do
    check.run(['db/migrate/01_foo.rb']).must_equal "It looks like you're adding a migration, but did not update the schema file"
  end

  it "fails if migration is missing" do
    check.run(['db/schema.rb']).must_equal "You're trying to change the schema without adding a migration file"
  end
end
