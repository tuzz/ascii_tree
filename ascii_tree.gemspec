Gem::Specification.new do |s|
  s.name        = "ascii_tree"
  s.version     = "1.0.0"
  s.summary     = "Ascii Tree"
  s.description = "Parses a usable tree from ASCII art."
  s.author      = "Chris Patuzzo"
  s.email       = "chris@patuzzo.co.uk"
  s.homepage    = "https://github.com/tuzz/ascii_tree"
  s.files       = ["README.md"] + Dir["lib/**/*.*"]
  s.licenses    = ["MIT"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
end
