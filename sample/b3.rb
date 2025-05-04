require 'modeling'

class Foo

  model :a

end

class Bar < Foo

  model :b

end

bar = Bar.new a: 1, b: 2
p bar  # => #<Bar:0x... @b=2, @a=1>

barbara = Bar.new 1, 2
p barbara  # => #<Bar:0x... @b=1, @a=2>