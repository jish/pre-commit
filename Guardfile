
guard :minitest, test_file_patterns: %w[*_test.rb], all_on_start: false do
  watch(%r{^test/(.*)_test\.rb})
  watch(%r{^lib/plugins/pre_commit/(.+)\.rb}) { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r{^lib/pre-commit/([^/]+)\.rb}) { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb})  { 'test' }
end
