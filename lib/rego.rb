require 'time'
require 'pathname'
require 'yaml'
require 'tmpdir'
require 'shellwords'

module Rego
  require_relative 'rego/_lib'
  require_relative 'rego/utils'
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
