# frozen_string_literal: true

require "reline"

module Debugger
  class Session
    def suspend!(binding)
      display_code(binding)

      while input = Reline.readline("(debug) ")
        case input
        when "continue"
          break
        when "exit"
          exit
        else
          puts "=> " + eval_input(binding, input).inspect
        end
      end
    end

    private

    def eval_input(binding, input)
      binding.eval(input)
    rescue Exception => e
      puts "Evaluation error: #{e.inspect}"
    end

    def display_code(binding)
      file, current_line = binding.source_location

      if File.exist?(file)
        lines = File.readlines(file)
        end_line = [current_line + 5, lines.count].min - 1
        start_line = [end_line - 9, 0].max
        puts "[#{start_line + 1}, #{end_line + 1}] in #{file}"
        max_lineno_width = (end_line + 1).to_s.size
        lines[start_line..end_line].each_with_index do |line, index|
          lineno = start_line + index + 1
          lineno_str = lineno.to_s.rjust(max_lineno_width)

          if lineno == current_line
            puts " => #{lineno_str}| #{line}"
          else
            puts "    #{lineno_str}| #{line}"
          end
        end
      end
    end
  end

  SESSION = Session.new
end

class Binding
  def debug
    Debugger::SESSION.suspend!(self)
  end
end