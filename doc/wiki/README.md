Welcome to the _modeling_ documentation home page!
===

Installation
---
```
gem install modeling
```

Usage
---
### 1. ::model with initializer
```RUBY
require 'modeling'

class Foo

  model :a, :@b do |**na|
    p na
  end

end

foo = Foo.new 1, 2 # => {:a=>1, :b=>2}
p foo  # => #<Foo:0x... @a=1, @b=2>
p foo.public_methods(false).sort  # => [:a, :a=]
```

### 2. Enable modeling only for selected classes
```RUBY
require 'modeling/module'

class Foo
  extend Modeling

  model :a, :b
end

foo = Foo.new 1, 2
p foo  # => #<Foo:0x... @a=1, @b=2>
```

### 3. Modeling with symbols
```RUBY
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
```

### 4. Alternative ways of modeling
```RUBY
require 'modeling'

class Bar
  model :@T_d
end

class Foo
  model "W_a", :Rb, "c", *Bar.model_fields
end

foo = Foo.new 1, 2
p foo  # => #<Foo:0x... @c=1, @d=2>
p foo.public_methods(false).sort  # => [:a=, :b, :c, :c=, :d?]
```

### 5. Mixed keyword and positional arguments
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

### 6. Inheritance
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

### 7. Modeled inheritance
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

### 8. Explicit super initialization
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

