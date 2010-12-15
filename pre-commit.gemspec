# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pre-commit}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Shajith Chacko, Josh Lubaway"]
  s.date = %q{2010-12-15}
  s.default_executable = %q{pre-commit}
  s.email = %q{dontneedmoreemail@example.com}
  s.executables = ["pre-commit"]
  s.extra_rdoc_files = ["README.md"]
  s.files = ["pre-commit.gemspec", "README.md", "bin/pre-commit", "lib/pre-commit/check.rb", "lib/pre-commit/checks.rb", "lib/pre-commit/grep_helper.rb", "lib/pre-commit/utils.rb", "lib/pre-commit.rb", "lib/support/all.rb", "lib/support/closure/closure_checker.rb", "lib/support/closure/compiler.jar", "lib/support/jslint/jslint_checker.rb", "lib/support/jslint/lint.js", "lib/support/whitespace/whitespace", "lib/support/whitespace/whitespace_checker.rb"]
  s.homepage = %q{http://github.com/jish/pre-commit}
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{What this thing does}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
