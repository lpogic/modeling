require 'modeling'

class Foo

  model :@a, :b, :@c do
    p a  # => 1
    p b  # => 2
    p c  # => 3
  end

end

foo = Foo.new 1, 2, 3 
p foo  # => #<Foo:0x... @a=1, @c=3>
p foo.methods  # => [:a, :c, :a=, :c=, ...