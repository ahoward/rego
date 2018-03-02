require 'time'
require 'pathname'
require 'yaml'
require 'tmpdir'

module Rego
  require_relative 'rego/_lib.rb'
  require_relative 'rego/utils.rb'
end

# gems
#
begin
  require 'rubygems'
rescue LoadError
  nil
end

if defined?(gem)
  Rego.dependencies.each do |lib, dependency|
    gem(*dependency)
    require(lib)
  end
end
