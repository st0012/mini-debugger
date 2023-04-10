def greeting(word)
  puts "Hello #{word}!"
end

TracePoint.trace(:line) do |tp|
  puts "#{tp.path}:#{tp.lineno} is being executed. Locals: #{tp.binding.local_variables}"
end

greeting("RubyKaigi")