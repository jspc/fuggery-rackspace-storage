Gem::Specification.new do |s|
  s.name = "fuggery-rackspace-storage"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["jspc"]
  s.date = "2014-01-04"
  s.description = "Libraries and tools for talking to the storage side of Rackspace"
  s.summary = "Rackspace API tools"
  s.email = "jame.condron@fundingcircle.com"
  s.homepage = "https://fundingcircle.com"
  s.executables = ["fuggery-volumes"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "README.md" ,
    "bin/fuggery-volumes" ,
    "lib/fuggery/rackspace/errors.rb" ,
    "lib/fuggery/rackspace/storage.rb" ,
   ]
   s.add_dependency( 'fog', '=1.19.0' )
   s.add_dependency( 'unf',  '=0.1.3' )
end
