require 'modeling'

class Foo

  model :@a, :b

end

class Bar < Foo
  def initialize a
    super(a)
  end
end

bar = Bar.new 1
p bar  # => #<Bar:0x... @a=1>