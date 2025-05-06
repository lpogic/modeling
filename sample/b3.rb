require 'modeling'

class Foo
  model :a
end

class Bar < Foo
  model :b, :<, keywords: true
end

bar = Bar.new a: 1, b: 2
p bar  # => #<Bar:0x... @a=1, @b=2>

barbara = Bar.new 1, 2
p barbara  # => #<Bar:0x... @a=2, @b=1>