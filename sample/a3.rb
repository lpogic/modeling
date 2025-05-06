require 'modeling'

class Bar
  def initialize *a
    p a
  end
end

class Foo < Bar
  model :a, :@b, :c=, :d!
end

foo = Foo.new 1, 2, 3, 4 # => [4]
p foo  # => #<Foo:0x... @a=1, @b=2>
p foo.public_methods(false).sort  # => [:a, :a=]
p foo.method(:initialize).parameters # => [[:opt, :a], [:opt, :b], [:opt, :c], [:opt, :d]]

# Symbol legend:
# a: assign to attribute, generate reader and writer
# @b: assign to attribute
# c=: do not create attribute for this argument
# d!: send this argument to super initialize