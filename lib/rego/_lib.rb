module Rego
  Version = '3.2.1' unless defined?(Version)

  def self.version
    Rego::Version
  end

  def self.dependencies
    {
      'main' => ['main', ' ~> 6.3.0'],
      'map' => ['map', ' ~> 6.6.0'],
      'listen' => ['listen', ' ~> 3.8.0']
    }
  end

  def self.libdir(*args, &block)
    @libdir ||= File.basename(File.expand_path(__FILE__).sub(/\.rb$/, ''))
    args.empty? ? @libdir : File.join(@libdir, *args)
  ensure
    if block
      begin
        $LOAD_PATH.unshift(@libdir)
        block.call
      ensure
        $LOAD_PATH.shift
      end
    end
  end

  def self.load(*libs)
    libs = libs.join(' ').scan(/[^\s+]+/)
    Rego.libdir { libs.each { |lib| Kernel.load(lib) } }
  end
end
