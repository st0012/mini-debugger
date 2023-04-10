class Foo
  def initialize
    @name = "foo"
  end

  def get_binding(x)
    binding
  end
end

puts binding.eval("self") #=> main

b = Foo.new.get_binding("bar")
puts b.eval("self") #=> #<Foo:0x00007f9b1a0b0e60>
puts b.eval("@name") #=> "foo"
puts b.eval("x") #=> "bar"
puts b.source_location.to_s #=> ["examples/binding.rb", 7]