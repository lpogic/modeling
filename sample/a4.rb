require 'modeling'

class Foo

  model "a/w", "b/r", "c/ra", "d/wat"

end

foo = Foo.new 1, 2, 3, 4
p foo  # => #<Foo:0x... @c=3, @d=4>
p foo.methods  # => [:a=, :b, :c, :d=, :d?, ...

# a - generate & assign attribute
# r - generate attr_reader
# w - generate attr_writer
# t - generate attr_tester