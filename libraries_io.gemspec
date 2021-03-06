
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "libraries_io/version"

Gem::Specification.new do |spec|
  spec.name          = "libraries_io"
  spec.version       = LibrariesIO::VERSION
  spec.authors       = ["Marc-Andre Lafortune"]
  spec.email         = ["github@marc-andre.ca"]

  spec.summary       = %q{A Wrapper for libraries.io}
  spec.description   = %q{A Wrapper for libraries.io built on tlaw}
  spec.homepage      = "https://github.com/marcandre/libraries_io"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.1.0'

  spec.add_runtime_dependency "tlaw"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "vcr", "~> 3.0"
end
