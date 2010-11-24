# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{abingo}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Weplay"]
  s.date = %q{2010-11-23}
  s.description = %q{Incorperate AB Testing into your rails apps}
  s.email = %q{tech@weplay.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "MIT-LICENSE",
    "README",
    "Rakefile",
    "VERSION",
    "abingo.gemspec",
    "generators/abingo_migration/abingo_migration_generator.rb",
    "generators/abingo_migration/templates/abingo_migration.rb",
    "init.rb",
    "install.rb",
    "lib/abingo.rb",
    "lib/abingo/alternative.rb",
    "lib/abingo/conversion_rate.rb",
    "lib/abingo/experiment.rb",
    "lib/abingo/statistics.rb",
    "lib/abingo_sugar.rb",
    "lib/abingo_view_helper.rb",
    "strip.rb",
    "test/abingo_test.rb",
    "test/test_helper.rb",
    "uninstall.rb"
  ]
  s.homepage = %q{http://github.com/weplay/abingo}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A/B Testing for Rails}
  s.test_files = [
    "test/abingo_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
