require 'modeling'

class Foo

  model :a, :b?, :c=, :@d, :e!

end

foo = Foo.new 1, 2, 3, 4, 5
p foo  # => #<Foo:0x... @a=1, @b=2, @c=3, @d=4>
p foo.methods  # => [:a=, :a, :b, :c=, ...


#         | :_  | :_? | :_= | :@_ | :_! |  
#         |_____|_____|_____|_____|_____|
# attr    |  1  |  1  |  1  |  1  |  0  |
#         |_____|_____|_____|_____|_____|
# reader  |  1  |  1  |  0  |  0  |  0  |
#         |_____|_____|_____|_____|_____|
# writer  |  1  |  0  |  1  |  0  |  0  |
#         |_____|_____|_____|_____|_____|
#         public   | writeonly |  noattr(argument passed to initializer block only)
#              readonly     private