module Kernel
  # http://extensions.rubyforge.org/rdoc/classes/Kernel.html
  # `require_relative` is new to Ruby 1.9, so we define it here just in case an interviewee is running 1.8 or lower
  def require_relative(path)
    require File.join(File.dirname(caller[0]), path.to_str)
  end
end
