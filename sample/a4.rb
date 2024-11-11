require 'modeling'

def Bar
  model :@ti_D
end

class Foo
  model "@w_a", :@R_b, "C", *Bar.model_fields
end

foo = Foo.new 1, 2, 3, 4
p foo  # => #<Foo:0x... @a=1, @b=2, @C=3>
p foo.public_methods(false).sort  # => [:C, :C=, :D?, :a=, :b]