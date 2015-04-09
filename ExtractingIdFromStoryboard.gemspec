# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extracting_id/version'

Gem::Specification.new do |spec|
  spec.name          = "ExtractingIdFromStoryboard"
  spec.version       = ExtractingId::VERSION
  spec.authors       = ["akuraru"]
  spec.email         = ["akuraru@gmail.com"]

  spec.summary       = %q{this tool for extracting ids from Storyboard}
  spec.description   = %q{this tool for extracting ids from Storyboard. Were extracted by specifying the Storyboard, it will be defined together in Header file  spec.homepage      = "https://github.com/akuraru/ExtractingIdFromStoryboard"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://github.com/akuraru/ExtractingIdFromStoryboard"
  end

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
