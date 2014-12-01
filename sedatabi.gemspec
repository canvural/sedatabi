# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sedatabi/version'

Gem::Specification.new do |spec|
  spec.name          = "sedatabi"
  spec.version       = Sedatabi::VERSION
  spec.authors       = ["canvural"]
  spec.email         = ["can9119@gmail.com"]
  spec.summary       = %q{Sedat Abi bir gün herkes olacak!}
  spec.description   = %q{Bir resimdeki yüzleri bulup, Sedat Abi'nin yüzü ile değiştiren bir uygulama.}
  spec.homepage      = "http://github.com/canvural/sedatabi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.requirements << 'OpenCV'
  spec.requirements << 'imagemagick'

  spec.add_dependency "instagram", "~>1.1"
  spec.add_dependency "mini_magick", "~> 3.8.1"
  spec.add_dependency "ruby-opencv", "~> 0.0.13"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
