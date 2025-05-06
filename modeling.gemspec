require_relative "./lib/modeling/version"

Gem::Specification.new do |s|
  s.name = "modeling"
  s.version = Modeling::VERSION
  s.summary = "A gem for writing class initializers more concisely."
  s.description = <<~xx
    A common pattern in initializers is to take each argument and assign it to an identically named instance variable. 
    In pure Ruby you would need to repeat each variable name 3 times to do this. This gem allows you to eliminate these repetitions.
    Moreover, it can also define attribute accessors for free.
  xx
  s.authors = ["Łukasz Pomietło"]
  s.email = "oficjalnyadreslukasza@gmail.com"
  s.files = Dir.glob('lib/**/*')
  s.homepage = "https://github.com/lpogic/modeling"
  s.license = "Zlib"
  s.required_ruby_version = ">= 3.4"
  s.metadata = {
    "documentation_uri" => "https://github.com/lpogic/modeling/blob/main/doc/wiki/README.md",
    "homepage_uri" => "https://github.com/lpogic/modeling"
  }
end