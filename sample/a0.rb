require 'modeling'

class Foo

  model :first, :second
  
end

# above and below are identical definitions

class Foo

  def initialize first, second
    @first = first
    @second = second
  end

  attr_accessor :first, :second

end