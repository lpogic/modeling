require 'modeling'

class Foo

  model :a, :R_b, :Wc, :@__d, :@RWe

end

foo = Foo.new 1, 2, 3, 4
p foo  # => #<Foo:0x... @a=1, @_d=4, @e=nil>
p foo.public_methods(false).sort  # => [:a, :a=, :b, :c=, :e, :e=]

# R = create attr_reader
# W = create attr_writer
# @ = create instance variable
# _ = optional options part delimiter (only first one, rest belongs to the name part)
# when no options: @RW