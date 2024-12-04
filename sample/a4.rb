require 'modeling'

class Bar
  model :@T_d
end

class Foo
  model "W_a", :Rb, "c", *Bar.model_fields
end

foo = Foo.new 1, 2
p foo  # => #<Foo:0x... @c=1, @d=2>
p foo.public_methods(false).sort  # => [:a=, :b, :c, :c=, :d?]