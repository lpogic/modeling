require 'modeling'

class Foo

  model :a, :@b do |mi|
    p [mi.a, mi.b]
  end

end

foo = Foo.new 1, b: 2 # => [1, 2]
p foo  # => #<Foo:0x... @a=1, @b=2>
p foo.public_methods(false).sort  # => [:a, :a=]