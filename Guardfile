
guard :minitest, test_file_patterns: %w[*_test.rb], all_on_start: false do
  watch(%r{^test/unit/(.*)_test\.rb})
  watch(%r{^lib/pre-commit/checks/([^/]+)\.rb}) { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb})  { 'test' }
end
