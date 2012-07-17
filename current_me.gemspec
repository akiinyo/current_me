# -*- encoding: utf-8 -*-
require File.expand_path('../lib/current_me/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tagaki Aki"]
  gem.email         = ["aki.hosecarioka@gmail.com"]
  gem.description   = %q{possess a current user}
  gem.summary       = %q{CurrentMe possesses a current user by a session}
  gem.homepage      = "https://github.com/akiinyo/current_me"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "current_me"
  gem.require_paths = ["lib"]
  gem.version       = CurrentMe::VERSION

  gem.add_dependency 'activesupport', ['>= 3.0.0']
  gem.add_dependency 'actionpack', ['>= 3.0.0']
end
