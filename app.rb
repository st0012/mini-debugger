require "debugger"

def fib(num)
  if num < 2
    num
  else
    binding.debug
    fib(num-1) + fib(num-2)
  end
end

a = fib(6)
b = fib(7)
puts a + b
