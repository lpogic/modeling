require 'modeling'

class Foo

  model :a, :@_b do |**na|
    p na
  end

end

foo = Foo.new 1, 2 # => {:a=>1, :b=>2}
p foo  # => #<Foo:0x... @a=1>
p foo.public_methods(false).sort  # => [:a, :a=]