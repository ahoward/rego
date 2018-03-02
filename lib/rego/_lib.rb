module Rego
  Version = '2.0.1' unless defined?(Version)

  def Rego.version
    Rego::Version
  end

  def Rego.dependencies
    {
      'main'       =>  [ 'main'       , ' ~> 6.0'    ]  , 
      'map'        =>  [ 'map'        , ' ~> 6.6'  ]  , 
      'rb-fsevent' =>  [ 'rb-fsevent' , ' ~> 0.10' ]  , 
    }
  end

  def Rego.libdir(*args, &block)
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

  def Rego.load(*libs)
    libs = libs.join(' ').scan(/[^\s+]+/)
    Rego.libdir{ libs.each{|lib| Kernel.load(lib) } }
  end
end
