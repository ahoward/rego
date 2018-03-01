module Rego
  def Rego.realpath(path)
    Pathname.new(path).realpath.to_s
  end

  def Rego.tmpdir(&block)
    tmpdir = File.join(Dir.tmpdir, ['rego', Process.ppid.to_s, Process.pid.to_s, Thread.current.object_id.to_s].join('-') + '.d')

    FileUtils.mkdir_p(tmpdir)

    if block
      begin
        Dir.chdir(tmpdir, &block)
      ensure
        FileUtils.rm_rf(tmpdir)
        at_exit{ `rm -rf #{ tmpdir }` }
      end
    else
      tmpdir
    end
  end

  def Rego.say(phrase, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    options[:color] = args.shift.to_s.to_sym unless args.empty?
    keys = options.keys
    keys.each{|key| options[key.to_s.to_sym] = options.delete(key)}

    color = options[:color]
    bold = options.has_key?(:bold)

    parts = [phrase]

    if STDOUT.tty?
      parts.unshift(ANSI[color]) if color
      parts.unshift(ANSI[:bold]) if bold
      parts.push(ANSI[:clear]) if parts.size > 1
    end

    method = options[:method] || :puts

    send(method, parts.join)
  end

  ANSI = {
    :clear      => "\e[0m",
    :reset      => "\e[0m",
    :erase_line => "\e[K",
    :erase_char => "\e[P",
    :bold       => "\e[1m",
    :dark       => "\e[2m",
    :underline  => "\e[4m",
    :underscore => "\e[4m",
    :blink      => "\e[5m",
    :reverse    => "\e[7m",
    :concealed  => "\e[8m",
    :black      => "\e[30m",
    :red        => "\e[31m",
    :green      => "\e[32m",
    :yellow     => "\e[33m",
    :blue       => "\e[34m",
    :magenta    => "\e[35m",
    :cyan       => "\e[36m",
    :white      => "\e[37m",
    :on_black   => "\e[40m",
    :on_red     => "\e[41m",
    :on_green   => "\e[42m",
    :on_yellow  => "\e[43m",
    :on_blue    => "\e[44m",
    :on_magenta => "\e[45m",
    :on_cyan    => "\e[46m",
    :on_white   => "\e[47m"
  }
end
