module DebugHelpers
  def debug(issue, notification)
    if @debugs[issue]
      $stdout.write(notification)
    else
      @debugs[issue] = 0
      Kernel.puts(issue)
    end

    @debugs[issue] += 1
  end

  Before = lambda do |scenario|
    @debugs = {}
  end.freeze

  After = lambda do |scenario|
    if scenario.failed? && !!ENV['DEBUG']
      require 'pry'
      binding.pry
    end
  end.freeze
end
