require 'modeling'

class Foo

  model :a, :R_b, :W_c, :T_d, :A_e, :V__f, :@g, :@RT_h

end

foo = Foo.new 1, 2, 3, 4
p foo  # => #<Foo:0x... @a=1, @_f=nil, @g=3, @h=4>
p foo.public_methods(false).sort  # => [:a, :a=, :b, :c=, :d?, :h, :h?]

# R: Reader
# W: Writer
# T: Tester (method with '?' suffix, returns false if variable is nil/false, true otherwise)
# A: Initialize Argument (accepts field during initialization)
# V: Instance Variable (create instance variable)
# @: Initialize Argument + Instance Variable
# _: separates options and name
# when no options: like RWAV