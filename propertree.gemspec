# frozen_string_literal: true

require_relative "lib/propertree/version"

Gem::Specification.new do |spec|
  spec.name = "propertree"
  spec.version = Propertree::VERSION
  spec.authors = ["Raph Estrada"]
  spec.email = ["raphael.estrada@gmx.de"]

  spec.summary = "Calculates property prices based on which trees are nearby."
  spec.homepage = "https://github.com/estraph/propertree"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata = { "github_repo" => "ssh://github.com/estraph/propertree" }
  spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", "~> 8.0.2"
  spec.add_dependency "activerecord", "~> 8.0.2"
  spec.add_dependency "csv", "~> 3.3.5"
  spec.add_dependency "sqlite3", "~> 2.7.2"
end
