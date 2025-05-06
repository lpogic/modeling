modeling _A gem for writing class initializers more concisely._
===

A common pattern in initializers is to take each argument and assign it to an identically named instance variable. 
In pure Ruby you would need to repeat each variable name 3 times to do this. This gem allows you to eliminate these repetitions.
Moreover, it can also define attribute accessors for free.


Version: 0.2.0

Basic sample
---
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

[More samples](https://github.com/lpogic/modeling/tree/0.2/doc/wiki)

Requirements
---
- Ruby version: >= 3.4

Installation
---
```
gem install modeling
```

Authors
---
- Łukasz Pomietło (oficjalnyadreslukasza@gmail.com)
