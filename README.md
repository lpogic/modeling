modeling
===

A concise way to define the class shape

Installation
---
```
gem install modeling
```

Usage
---
### 1. Basic use case
```RUBY
require 'modeling'

class Foo

  model :@first, :@second
  
end

# ==

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

  model :@a, :b do |**na|
    p na[:a]
    p na[:b]
  end

end

foo = Foo.new 1, 2 
# => 1
# => 2
p foo  # => #<Foo:0x... @a=1>
p foo.methods  # => [:a=, :a, ...
```

### 3. Don't enable Modeling globally
```RUBY
require 'modeling/module'

class Foo
  extend Modeling

  model :@a, :b, :@c

end

foo = Foo.new 1, 2, 3 
p foo  # => #<Foo:0x... @a=1, @c=3>
```

### 4. Symbol encoded model fields
```RUBY
require 'modeling'

class Foo

  model :@a, :b, :c!, :d?

end

foo = Foo.new 1, 2, 3, 4
p foo  # => #<Foo:0x... @a=1, @d=4>
p foo.methods  # => [:a=, :a, :c=, :c, ...


#        | :_  | :_! | :_? | :@_ |  
#        |_____|_____|_____|_____|
# attr   |  0  |  0  |  1  |  1  |
#        |_____|_____|_____|_____|
# reader |  0  |  1  |  0  |  1  |
#        |_____|_____|_____|_____|
# writer |  0  |  1  |  0  |  1  |
#        |_____|_____|_____|_____|

```

### 5. String encoded model fields
```RUBY
require 'modeling'

class Foo

  model "a=", "b.", "c .?", "d !?"

end

foo = Foo.new 1, 2, 3, 4
p foo  # => #<Foo:0x... @c=3, @d=4>
p foo.methods  # => [:a=, :b, :c, :d=, :d, ...


#        | = | . | ! | ? | @ |
#        |___|___|___|___|___|
# attr   | 0 | 0 | 0 | 1 | 1 |
#        |___|___|___|___|___|
# reader | 0 | 1 | 1 | 0 | 1 |
#        |___|___|___|___|___|
# writer | 1 | 0 | 1 | 0 | 1 |
#        |___|___|___|___|___|
```

### 6. Mixed keyword and positional arguments
```RUBY
require 'modeling'

class Foo

  model :@a, :@b, :@c

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

  model :@a, :b

end

class Bar < Foo
  def initialize a
    super(a)
  end
end

bar = Bar.new 1
p bar  # => #<Bar:0x... @a=1>
```

### 8. Modeled inheritance
```RUBY
require 'modeling'

class Foo

  model :@a

end

class Bar < Foo

  model :@b

end

bar = Bar.new a: 1, b: 2
p bar  # => #<Bar:0x... @a=1, @b=2>

rabar = Bar.new 1, 2
p rabar  # => #<Bar:0x... @a=2, @b=1>
```

Authors
---
- Łukasz Pomietło (oficjalnyadreslukasza@gmail.com)
