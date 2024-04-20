require 'modeling'

class Foo

  model :a

end

class Bar < Foo

  model :b do |super_proc|
    super_proc.call a: @b
  end

end

rabar = Bar.new 1
p rabar  # => #<Bar:0x... @a=1, @b=1>