modeling - A concise way to define the class shape
===

    Simplify common class definition by encoding attributes with their access modes.


Installation
---
```
gem install modeling
```

Usage
---
### 1. Basic concept
```RUBY
require 'modeling'

# with modeling:

class Foo
  model :first, :@ir_second
end

# without modeling:

class Foo
  def initialize _first = nil, _second = nil, **na
    @first = na.key?(:first) ? na[:first] : _first
    @second = na.key?(:second) ? na[:second] : _second
  end

  attr_accessor :first
  attr :second
end
```

### 2. ::model with initializer
```RUBY
require 'modeling'

class Foo

  model :a, :@_b do |**na|
    p na
  end

end

foo = Foo.new 1, 2 # => {:a=>1, :b=>2}
p foo  # => #<Foo:0x... @a=1>
p foo.public_methods(false).sort  # => [:a, :a=]
```

### 3. Enable modeling only for selected classes
```RUBY
require 'modeling/module'

class Foo
  extend Modeling

  model :a, :b
end

foo = Foo.new 1, 2
p foo  # => #<Foo:0x... @a=1, @b=2>
```

### 4. Modeling with symbols
```RUBY
require 'modeling'

class Foo

  model :a, :@i_b, :@ir_c, :@wrt_d, :@it_e

end

foo = Foo.new 1, 2, 3, 4, 5
p foo  # => #<Foo:0x... @a=1, @b=2, @c=3, @e=5>
p foo.public_methods(false).sort  # => [:a, :a=, :c, :d, :d=, :d?, :e?]

# @r - reader
# @w - writer
# @t - tester
# @i - instance variable
```

### 5. Alternative ways of modeling
```RUBY
require 'modeling'

class Bar
  model :@ti_D
end

class Foo
  model "@w_a", :@R_b, "C", *Bar.model_fields
end

foo = Foo.new 1, 2, 3, 4
p foo  # => #<Foo:0x... @C=3, @D=4>
p foo.public_methods(false).sort  # => [:C, :C=, :D?, :a=, :b]
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
p bar  # => #<Bar:0x... @b=2, @a=1>

rabar = Bar.new 1, 2
p rabar  # => #<Bar:0x... @b=1, @a=2>
```

### 9. Explicit super initialization
```RUBY
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
```


Authors
---
- Łukasz Pomietło (oficjalnyadreslukasza@gmail.com)
