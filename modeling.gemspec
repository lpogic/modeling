require_relative "./lib/modeling/version"

Gem::Specification.new do |s|
  s.name        = "modeling"
  s.version     = Modeling::VERSION
  s.summary     = "A concise way to define the class shape"
  s.description = <<-EOT
    Simplify common class definition by encoding attributes with their access modes.
  EOT
  s.authors     = ["Łukasz Pomietło"]
  s.email       = "oficjalnyadreslukasza@gmail.com"
  s.files       = Dir.glob('lib/**/*')
  s.homepage    = "https://github.com/lpogic/modeling"
  s.license       = "Zlib"
  s.required_ruby_version     = ">= 3.2.2"
  s.metadata = {
    "documentation_uri" => "https://github.com/lpogic/modeling/blob/main/doc/wiki/README.md",
    "homepage_uri" => "https://github.com/lpogic/modeling"
  }
end