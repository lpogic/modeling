Welcome to the _modeling_ documentation home page!
===

Version: 0.2.0

[Go to the project home page](https://github.com/lpogic/modeling/tree/0.2)

Installation
---
```
gem install modeling
```

Basic usage
---
### 1. Comparison with traditional initialize
```RUBY
# with modeling:

require 'modeling'

class Foo
  model :@first, :second
end

# without modeling:

class Foo
  def initialize first, second
    @first = first
    @second = second
  end

  attr_accessor :second
end
```

### 2. Custom initialize body
```RUBY
require 'modeling'

class Foo
  model :a, :@b, <<-'RUBY'
    puts "This is a custom initialize body."
    puts "a + b = #{a + b}"
  RUBY
end

foo = Foo.new 1, 2
# => This is a custom initialize body.
# => a + b = 3

p foo  # => #<Foo:0x... @a=1, @b=2>
p foo.public_methods(false).sort  # => [:a, :a=]
```

### 3. Enabling modeling locally
```RUBY
require 'modeling/module'

class Foo
  extend Modeling

  model :a, :b
end

foo = Foo.new 1, 2
p foo  # => #<Foo:0x... @a=1, @b=2>
```

### 4. Arguments encoding
```RUBY
require 'modeling'

class Bar
  def initialize *a
    p a
  end
end

class Foo < Bar
  model :a, :@b, :c=, :d!
end

foo = Foo.new 1, 2, 3, 4 # => [4]
p foo  # => #<Foo:0x... @a=1, @b=2>
p foo.public_methods(false).sort  # => [:a, :a=]
p foo.method(:initialize).parameters # => [[:opt, :a], [:opt, :b], [:opt, :c], [:opt, :d]]

# Symbol legend:
# a: assign to attribute, generate reader and writer
# @b: assign to attribute
# c=: do not create attribute for this argument
# d!: send this argument to super initialize
```


Advanced usage
---
### 5. Modeling inheriting classes
```RUBY
require 'modeling'

class Bar
  model :@a, :b
end

class Foo < Bar
  model :c, :<
end

foo = Foo.new 1, 2, 3
p foo  # => #<Foo:0x... @a=2, @b=3, @c=1>

# ":<" means: Add all positional arguments from superclass to the initialize arguments
```

### 6. Enabling keyword arguments
```RUBY
require 'modeling'

class Foo
  model :a, :b, :c, keywords: true
end

foo = Foo.new 1, c: 2
p foo  # => #<Foo:0x... @a=1, @b=nil, @c=2>

bar = Foo.new 1, 2, 3, b: 4
p bar  # => #<Foo:0x... @a=1, @b=4, @c=3>

# "keywords: true" allows passing some attributes by keyword
```

### 7. Modeling inherited classes
```RUBY
require 'modeling'

class Foo
  model :a, :b
end

class Bar < Foo
  def initialize a
    super
  end
end

bar = Bar.new 1
p bar  # => #<Bar:0x... @a=1, @b=nil>
```

### 8. Inheritance & keyword arguments
```RUBY
require 'modeling'

class Foo
  model :a
end

class Bar < Foo
  model :b, :<, keywords: true
end

bar = Bar.new a: 1, b: 2
p bar  # => #<Bar:0x... @a=1, @b=2>

barbara = Bar.new 1, 2
p barbara  # => #<Bar:0x... @a=2, @b=1>
```

### 9. Explicit super initialization
```RUBY
require 'modeling'

class Foo
  model :a
end

class Bar < Foo
  model :b, 'super(b)'
end

bar = Bar.new 1
p bar  # => #<Bar:0x... @b=1, @a=1>
```

