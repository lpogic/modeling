require 'modeling'

class Foo

  model :a, :@_b, :@r_c, :@wrt_d, :@it_e

end

foo = Foo.new 1, 2, 3, 4, 5
p foo  # => #<Foo:0x... @a=1, @b=2, @c=3, @d=4>
p foo.public_methods(false).sort  # => [:a, :a=, :c, :d, :d=, :d?, :e?]

# @r - reader
# @w - writer
# @t - tester
# @i - initializer variable (not attribute)