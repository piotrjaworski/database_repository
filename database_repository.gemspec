# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "database_repository/version"

Gem::Specification.new do |spec|
  spec.name          = "database_repository"
  spec.version       = DatabaseRepository::VERSION
  spec.authors       = ["Piotr Jaworski"]
  spec.email         = ["piotrek.jaw@gmail.com"]

  spec.summary       = %q{Simple database repository pattern for ActiveRecord.}
  spec.description   = %q{Gem which provides simple database repository pattern for ActiveRecord with predefined basics methods.}
  spec.homepage      = "https://github.com/piotrjaworski/database_repository"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", ">= 3.2"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.16"
end
