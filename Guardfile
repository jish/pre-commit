
guard :minitest, test_file_patterns: %w[*_test.rb], all_on_start: false do

  watch(%r{^lib/(.*)\.rb}) { |m| "test/unit/#{m[1]}_test.rb" }

  watch(%r{^lib/pre-commit\.rb}) { "test/integration_test.rb" }

  watch(%r{^lib/pre-commit/support/(.*)/.*}) { |m| "test/unit/checks/#{m[1]}_test.rb" }

  watch(%r{^test/(.*)_test\.rb})

  watch(%r{^test/files/.*}) { "test/unit/plugins/pre_commit/checks" }

  watch(%r{^test/test_helper\.rb}) { 'test' }

  watch(%r{^templates/hooks/.*}) { ["test/unit/installer_test.rb", "test/unit/cli_test.rb"] }

  watch(%r{^templates/hooks/automatic}) { "test/integration_test.rb" }
end
