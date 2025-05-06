# with modeling:

require 'modeling'

class Foo
  model :@first, :second
end

# without modeling:

class Foo
  def initialize first, second
    @first = first
    @second = second
  end

  attr_accessor :second
end