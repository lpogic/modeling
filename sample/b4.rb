require 'modeling'

class Foo

  model :a

end

class Bar < Foo

  model :b do |init_super|
    init_super.call a: @b
  end

end

rabar = Bar.new 1
p rabar  # => #<Bar:0x... @a=1, @b=1>