Gem::Specification.new do |s|
  s.name        = "ascii_tree"
  s.version     = "2.0.0"
  s.summary     = "Ascii Tree"
  s.description = "Parses a usable tree from ASCII art."
  s.author      = "Chris Patuzzo"
  s.email       = "chris@patuzzo.co.uk"
  s.homepage    = "https://github.com/tuzz/ascii_tree"
  s.files       = ["README.md"] + Dir["lib/**/*.*"]
  s.licenses    = ["MIT"]

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rake", "~> 10.4"
  s.add_development_dependency "rubocop", "~> 0.31"
end
