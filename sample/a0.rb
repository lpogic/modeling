require 'modeling'

class Foo

  model :@first, :@second
  
end

# ==

class Foo

  def initialize first, second
    @first = first
    @second = second
  end

  attr_accessor :first, :second

end