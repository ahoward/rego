require 'time'
require 'pathname'
require 'yaml'

module Rego
  Version = '1.0.0' unless defined?(Version)

  def version
    Rego::Version
  end

  def dependencies
    {
      'main'       => [ 'main'       , ' >= 4.8.1'   ] , 
      'rb-fsevent' => [ 'rb-fsevent' , ' >= 0.4.3.1' ]
    }
  end

  def libdir(*args, &block)
    @libdir ||= File.expand_path(__FILE__).sub(/\.rb$/,'')
    args.empty? ? @libdir : File.join(@libdir, *args)
  ensure
    if block
      begin
        $LOAD_PATH.unshift(@libdir)
        block.call()
      ensure
        $LOAD_PATH.shift()
      end
    end
  end

  def load(*libs)
    libs = libs.join(' ').scan(/[^\s+]+/)
    Rego.libdir{ libs.each{|lib| Kernel.load(lib) } }
  end

  extend(Rego)
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

