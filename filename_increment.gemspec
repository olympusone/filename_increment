require_relative 'lib/filename_increment/version'

Gem::Specification.new do |spec|
  spec.name = "filename_increment"
  spec.version = FilenameIncrement::VERSION
  spec.authors = ["Dimitrios Panagkasidis"]
  spec.email = ["dimidev@olympusone.com"]

  spec.summary = %q{Automatically add an increment or 'copy' to duplicate file names}
  spec.description = %q{When copying files, it's common for operating systems to append a numerical increment or
                        the word 'copy' to a file name to prevent the existing file from being overwritten.
                        This library allows you to do the same thing in your Ruby application.}
  spec.homepage = "https://rubygems.org/gems/filename_increment"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/olympusone/filename_increment"
  spec.metadata["changelog_uri"] = "https://github.com/olympusone/filename_increment/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
