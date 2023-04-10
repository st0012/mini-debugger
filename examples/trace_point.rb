TracePoint.trace(:line) do |tp|
  puts "Line #{tp.lineno} of #{tp.path} was executed"
  puts "locals: #{tp.binding.local_variables}"
end

def foo(n)
  puts n + 1
end

foo(10)