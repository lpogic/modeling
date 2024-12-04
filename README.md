modeling - A concise way to define the class shape
===

Adds the ability to quickly model classes. Definitions of instance variables and access methods are reduced to one line. 
Creating an instance of the modeled class is significantly slower (~20x), so its use for classes whose instances are created frequently is not recommended.


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
