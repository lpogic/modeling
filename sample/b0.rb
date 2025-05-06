require 'modeling'

class Bar
  model :@a, :b
end

class Foo < Bar
  model :c, :<
end

foo = Foo.new 1, 2, 3
p foo  # => #<Foo:0x... @a=2, @b=3, @c=1>

# ":<" means: Add all positional arguments from superclass to the initialize arguments