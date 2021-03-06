require 'egison/core'

class Class
  include PatternMatch::Matchable

  def uncons(val)
    raise NotImplementedError, "need to define `#{__method__}'"
  end

  private

  def accept_array_only(val)
    raise PatternMatch::PatternNotMatch unless val.kind_of?(Array)
  end
end

class List
end

class << List
  def uncons(val)
    accept_array_only(val)
    val2 = val.clone
    x = val2.shift
    [[x, val2]]
  end

  def unjoin(val)
    accept_array_only(val)
    val2 = val.clone
    xs = []
    ys = val2.clone
    rets = [[xs, ys]]
    until val2.empty? do
      x = val2.shift
      ys = val2.clone
      xs += [x]
      rets += [[xs, ys]]
    end
    rets
  end
end
