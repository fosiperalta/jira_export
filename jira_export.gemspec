# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jira_export/version'

Gem::Specification.new do |spec|
  spec.name          = "jira_export"
  spec.version       = JiraExport::VERSION
  spec.authors       = ["fosiperalta"]
  spec.email         = ["fosiperalta@gmail.com"]

  spec.summary       = %q{Export the done issues in a list of sprints from Jira.}
  spec.description   = %q{Export the done issues in a list of sprints from Jira.}
  spec.homepage      = "https://github.com/fosiperalta/jira_export/"
  spec.license       = "MIT"
  spec.executables = ["jira_export"]

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # spec.files = `git ls-files -z`.split("\x0").reject do |f|
  #   f.match(%r{^(test|spec|features|)/})
  # end
  spec.bindir = "bin"
  # spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_runtime_dependency "rest-client", "<= 1.8.0"
  spec.add_runtime_dependency "httparty"
end
