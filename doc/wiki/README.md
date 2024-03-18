Welcome to the _modeling_ documentation home page!
===

Usage
---
### 1. Basic use case
```RUBY
require 'modeling'

class Foo

  model :first, :second
  
end

# above and below are identical definitions

class Foo

  def initialize first, second
    @first = first
    @second = second
  end

  attr_accessor :first, :second

end
```

### 2. ::model with block
```RUBY
require 'modeling'

class Foo

  model :a, :@b do |**na|
    p na[:a]
    p na[:b]
  end

end

foo = Foo.new 1, 2 
# => 1
# => 2
p foo  # => #<Foo:0x... @a=1, @b=2>
p foo.methods  # => [:a=, :a, ...
```

### 3. Don't enable Modeling globally
```RUBY
require 'modeling/module'

class Foo
  extend Modeling

  model :a, :b, :@c

end

foo = Foo.new 1, 2, 3 
p foo  # => #<Foo:0x... @a=1, @b=2, @c=3>
```

### 4. Symbol encoded model fields
```RUBY
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
```

### 5. String encoded model fields
```RUBY
require 'modeling'

class Foo

  model "a/w", "b/r", "c/ra", "d/wat"

end

foo = Foo.new 1, 2, 3, 4
p foo  # => #<Foo:0x... @c=3, @d=4>
p foo.methods  # => [:a=, :b, :c, :d=, :d?, ...

# a - generate & assign attribute
# r - generate attr_reader
# w - generate attr_writer
# t - generate attr_tester
```

### 6. Mixed keyword and positional arguments
```RUBY
require 'modeling'

class Foo

  model :a, :b, :c

end

foo = Foo.new 1, c: 2
p foo  # => #<Foo:0x... @a=1, @b=nil, @c=2>

bar = Foo.new 1, 2, 3, b: 4
p bar  # => #<Foo:0x... @a=1, @b=4, @c=3>
```

### 7. Inheritance
```RUBY
require 'modeling'

class Foo

  model :a, :b

end

class Bar < Foo
  def initialize a
    super(a)
  end
end

bar = Bar.new 1
p bar  # => #<Bar:0x... @a=1, @b=nil>
```

### 8. Modeled inheritance
```RUBY
require 'modeling'

class Foo

  model :a

end

class Bar < Foo

  model :b

end

bar = Bar.new a: 1, b: 2
p bar  # => #<Bar:0x... @a=1, @b=2>

rabar = Bar.new 1, 2
p rabar  # => #<Bar:0x... @a=2, @b=1>
```
