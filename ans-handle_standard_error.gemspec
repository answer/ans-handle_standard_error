# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ans-handle_standard_error/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["sakai shunsuke"]
  gem.email         = ["sakai@ans-web.co.jp"]
  gem.description   = %q{standard error を rescue してログに書き出す}
  gem.summary       = %q{コントローラに include すると standard error を rescue するようになる}
  gem.homepage      = "https://github.com/answer/ans-handle_standard_error"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ans-handle_standard_error"
  gem.require_paths = ["lib"]
  gem.version       = Ans::HandleStandardError::VERSION
end
