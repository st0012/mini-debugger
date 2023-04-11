require "debugger"

def fib(num)
  if num < 2
    num
  else
    fib(num-1) + fib(num-2)
  end
end

binding.debug
a = fib(6)
b = fib(7)
puts a + b