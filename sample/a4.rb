require 'modeling'

class Bar
  model :@R_d
end

class Foo
  model "W_a", :Rb, "c", *Bar.model_fields
end

foo = Foo.new 1, 2, 3
p foo  # => #<Foo:0x... @c=3, @d=nil>
p foo.public_methods(false).sort  # => [:a=, :b, :c, :c=, :d]