## rego.gemspec
#

Gem::Specification::new do |spec|
  spec.name = "rego"
  spec.version = "4.2.2"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "rego"
  spec.description = "description: rego kicks the ass"
  spec.license = "Ruby"

  spec.files =
["README.md", "Rakefile", "bin", "bin/rego", "lib", "lib/rego", "lib/rego.rb", "lib/rego/_lib.rb", "lib/rego/utils.rb", "rego.gemspec"]
  spec.executables = ["rego"]
  
  spec.require_path = "lib"

  spec.test_files = nil

  
    spec.add_dependency(*["main", " ~> 6"])
  
    spec.add_dependency(*["map", " ~> 6"])
  
    spec.add_dependency(*["listen", " ~> 3.9"])
  

  spec.extensions.push(*[])

  spec.author = "Ara T. Howard"
  spec.email = "ara.t.howard@gmail.com"
  spec.homepage = "https://github.com/ahoward/rego"
end
