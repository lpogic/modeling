require 'modeling'

# with modeling:

class Foo
  model :first, :@ir_second
end

# without modeling:

class Foo
  def initialize _first = nil, _second = nil, **na
    @first = na.key?(:first) ? na[:first] : _first
    @second = na.key?(:second) ? na[:second] : _second
  end

  attr_accessor :first
  attr :second
end