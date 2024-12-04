modeling - A concise way to define the class shape
===

Simplify common class definition by encoding attributes with their access modes.


Basics
---
```RUBY
require 'modeling'

# with modeling:

class Foo
  model :first, :@R_second
end

# without modeling:

class Foo
  def initialize first, second
    @first = first
    @second = second
  end

  attr_accessor :first
  attr_reader :second
end
```

Installation
---
```
gem install modeling
```

Usage
---
[Wiki](https://github.com/lpogic/modeling/blob/main/doc/wiki/README.md)

Authors
---
- Łukasz Pomietło (oficjalnyadreslukasza@gmail.com)
