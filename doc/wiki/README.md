Welcome to the _procify_ documentation home page!
===

Usage
---
### 1. Basic use case
```RUBY
require 'modeling'

class Foo

  model :@first, :@second, :third

end

# is a definition equal to this one:

class Foo

  def initialize first, second, third
    @first = first
    @second = second
  end

  attr_accessor :first, :second

end
```

### 2. ::model with initialize body
```RUBY
require 'modeling'

class Foo

  model :@a, :b, :@c do
    p a  # => 1
    p b  # => 2
    p c  # => 3
  end

end

foo = Foo.new 1, 2, 3 
p foo  # => #<Foo:0x... @a=1, @c=3>
p foo.methods  # => [:a, :c, :a=, :c=, ...
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

### 4. String ::model argument
```RUBY
require 'modeling'

class Foo

  model :@a, "@b"

end

foo = Foo.new 1, 2
p foo  # => #<Foo:0x... @a=1, @b=2>
p foo.methods  # => [:a=, :a, ...
```

### 5. String ::model argument with accessors
```RUBY
require 'modeling'

class Foo

  model :@a, "@b +="

end

foo = Foo.new 1, 2
p foo  # => #<Foo:0x... @a=1, @b=2>
p foo.methods  # => [:a=, :a, :b= , :b, ...
```

### 6. Keywords and tester methods
```RUBY
require 'modeling'

class Foo

  model "@a?", "@b :+=?"

end

foo = Foo.new 1, 2
p foo  # => #<Foo:0x... @a=1, @b=2>
p foo.methods  # => [:a?, :b?, :b=, :b, ...

bar = Foo.new b: 3
p bar  # => #<Foo:0x... @a=nil, @b=3>
p bar.a? # => false
```
