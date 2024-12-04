require 'modeling'

# with modeling:

class Foo
  model :first, :@R_second
end

# without modeling:

class Foo
  def initialize first, second
    @first = first
    @second = second
  end

  attr_accessor :first
  attr_reader :second
end