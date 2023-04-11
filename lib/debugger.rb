# frozen_string_literal: true

require "reline"
require "rbconfig"

module Debugger
  class Session
    def initialize
      @breakpoints = []
    end

    def suspend!(binding, bp: nil)
      if bp
        puts "Suspended by: #{bp.name}"
        # The initial breakpoint is a one-time breakpoint, so we need to delete it after we hit it
        @breakpoints.delete(bp) if bp.once
      end

      display_code(binding)

      while input = Reline.readline("(debug) ")
        cmd, arg = input.split(" ", 2)

        case cmd
        when "break"
          case arg
          when /\A(\d+)\z/
            add_breakpoint(binding.source_location[0], $1.to_i)
          when /\A(.+)[:\s+](\d+)\z/
            add_breakpoint($1, $2.to_i)
          when nil
            if @breakpoints.empty?
              puts "No breakpoints"
            else
              @breakpoints.each_with_index do |bp, index|
                puts "##{index} - #{bp.location}"
              end
            end
          else
            puts "Unknown break format: #{arg}"
          end
        when "delete"
          index = arg.to_i

          if bp = @breakpoints.delete_at(index)
            bp.disable
            puts "Breakpoint ##{index} (#{bp.location}) has been deleted"
          else
            puts "Breakpoint ##{index} not found"
          end
        when "step"
          step_in
          break
        when "next"
          step_over
          break
        when "continue"
          break
        when "exit"
          exit
        else
          puts "=> " + eval_input(binding, input).inspect
        end
      end
    end

    # We add it to the public API because we'll need it later
    def add_breakpoint(file, line, **options)
      bp = LineBreakpoint.new(file, line, **options)
      @breakpoints << bp
      puts "Breakpoint added: #{bp.location}" unless bp.once
      bp.enable
    end

    private

    def step_in
      TracePoint.trace(:line) do |tp|
        # There are some internal files we don't want to step into
        next if internal_path?(File.expand_path(tp.path))

        # Disable the TracePoint after we hit the next execution
        tp.disable
        suspend!(tp.binding)
      end
    end

    def step_over
      # ignore call frames from the debugger itself
      current_depth = caller.length - 2

      TracePoint.trace(:line) do |tp|
        # There are some internal files we don't want to step into
        next if internal_path?(File.expand_path(tp.path))
        depth = caller.length

        next if current_depth < depth

        tp.disable
        suspend!(tp.binding)
      end
    end

    RELINE_PATH = Gem.loaded_specs["reline"].full_require_paths.first

    # 1. Check if the path is inside the debugger itself
    # 2. Check if the path is inside Ruby's standard library
    # 3. Check if the path is inside Ruby's internal files
    # 4. Check if the path is inside Reline
    def internal_path?(path)
      path.start_with?(__dir__) || path.start_with?(RbConfig::CONFIG["rubylibdir"]) ||
      path.match?(/<internal:/) || path.start_with?(RELINE_PATH)
    end

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

  class LineBreakpoint
    attr_reader :once

    def initialize(file, line, once: false)
      @file = file
      @line = line
      @once = once
      @tp =
        TracePoint.new(:line) do |tp|
          # we need to expand paths to make sure they'll match
          if File.expand_path(tp.path) == File.expand_path(@file) && tp.lineno == @line
            SESSION.suspend!(tp.binding, bp: self)
          end
        end
    end

    def location
      "#{@file}:#{@line}"
    end

    def name
      "Breakpoint at #{location}"
    end

    def enable
      @tp.enable
    end

    def disable
      @tp.disable
    end
  end
end

class Binding
  def debug
    Debugger::SESSION.suspend!(self)
  end
end

# If the program is run with `exe/debug`, we'll add a breakpoint at the first line
if ENV["RUBYOPT"] && ENV["RUBYOPT"].split.include?("-rdebugger")
  Debugger::SESSION.add_breakpoint($0, 1, once: true)
end