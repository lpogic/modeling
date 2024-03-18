require 'modeling/module'

class Foo
  extend Modeling

  model :a, :b, :@c

end

foo = Foo.new 1, 2, 3 
p foo  # => #<Foo:0x... @a=1, @b=2, @c=3>