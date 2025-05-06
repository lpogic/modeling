require 'benchmark/ips'
require 'modeling'


class Initialized
  def initialize a, b, c
    super()
    @a = a
    @b = b
    @c = c
  end
end


class Modeled
  model :a, :b, :c
end


def initialized
  2000.times do
    Initialized.new 1, 2, 3
  end
end

def modeled
  2000.times do
    Modeled.new 1, 2, 3
  end
end

Benchmark.ips do |x|
  x.report('initialize') { initialized }
  x.report('model') { modeled }
  x.compare!
end
