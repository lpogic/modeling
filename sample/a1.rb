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