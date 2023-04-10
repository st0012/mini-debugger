require "reline"

puts 'This is echo program by Reline.'

while line = Reline.readline("echo> ")
  case line.chomp
  when 'exit'
    exit 0
  else
    puts "=> #{line}"
  end
end