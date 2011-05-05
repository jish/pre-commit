require 'minitest/autorun'
require 'pre-commit/checks/migration_check'

class MigrationCheckTest < MiniTest::Unit::TestCase

  def test_should_fail_if_a_migration_is_added_but_not_a_schema_change
    check = PreCommit::MigrationCheck.new
    assert !check.run(['db/migrate/01_foo.rb'])

    assert !check.passed?
    assert check.error_message
  end

  def test_should_fail_if_the_schema_is_changed_and_no_migration_was_added
    check = PreCommit::MigrationCheck.new
    assert !check.run(['db/schema.rb'])

    assert !check.passed?
    assert check.error_message
  end

  def test_should_pass_if_there_is_a_schema_change_and_a_migration_was_added
    check = PreCommit::MigrationCheck.new
    assert check.run(['db/migrate/01_foo.rb', 'db/schema.rb'])

    assert check.passed?
    assert !check.error_message
  end

  def test_should_pass_if_other_random_files_were_changed
    check = PreCommit::MigrationCheck.new
    assert check.run(['public/javascript/foo.js', 'lib/bar.rb'])

    assert check.passed?
    assert !check.error_message
  end

  def test_should_detect_a_migration_file
    check = PreCommit::MigrationCheck.new
    assert !check.migration_file_present?([])
    assert check.migration_file_present?(['db/migrate/01_foo.rb'])
  end

  def test_should_detect_a_schema_file
    check = PreCommit::MigrationCheck.new
    assert !check.schema_file_present?([])
    assert check.schema_file_present?(['db/schema.rb'])
    assert check.schema_file_present?(['db/foo_structure.sql'])
    assert check.schema_file_present?(['db/structure_foo.sql'])
  end

end
