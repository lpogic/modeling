require 'modeling'

class Foo

  model :@first, :@second, :third

end

# is a definition equal to this one:

class Foo

  def initialize first, second, third
    @first = first
    @second = second
  end

  attr_accessor :first, :second

end