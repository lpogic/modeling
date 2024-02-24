require 'modeling'

class Foo

  model "@a?", "@b :+=?"

end

foo = Foo.new 1, 2
p foo  # => #<Foo:0x... @a=1, @b=2>
p foo.methods  # => [:a?, :b?, :b=, :b, ...

bar = Foo.new b: 3
p bar  # => #<Foo:0x... @a=nil, @b=3>
p bar.a? # => false