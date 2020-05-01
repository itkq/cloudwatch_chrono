require_relative 'lib/cloudwatch_chrono/version'

Gem::Specification.new do |spec|
  spec.name          = "cloudwatch_chrono"
  spec.version       = CloudwatchChrono::VERSION
  spec.authors       = ["Takuya Kosugiyama"]
  spec.email         = ["re@itkq.jp"]

  spec.summary       = %q{Chronology for CloudWatch cron expression.}
  spec.description   = %q{Chronology for CloudWatch cron expression.}
  spec.homepage      = "https://github.com/itkq/cloudwatch_chrono"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/itkq/cloudwatch_chrono"
  spec.metadata["changelog_uri"] = "https://github.com/itkq/cloudwatch_chrono/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "chrono"
  spec.add_development_dependency "pry"
end
