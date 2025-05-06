require 'modeling'

class Foo
  model :a
end

class Bar < Foo
  model :b, 'super(b)'
end

bar = Bar.new 1
p bar  # => #<Bar:0x... @b=1, @a=1>