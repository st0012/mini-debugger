# mini-debugger

This is a complemantry repo for my talk `Build a mini Ruby debugger in under 300 lines`.

## Demo

![Demo for the debugger with exe/debug](/examples/demo.gif)

## Usage

### Setup

- `bundle install`

### Commands

- `break` - list all breakpoints.
  - `break <line>` - add a breakpoint at `<line>` of the current file.
  - `break <file>:<line>` - add a breakpoint at the specified location.
- `delete <id>` - delete the specified breakpoint.
- `step` - step in. Continue the program until the next stoppable point.
- `next` - step over. Continue the program until the next line.
- `continue` - continue the program.
- `exit` - exit the program.

### The `exe/debug` executable

Debug a script with `$ bundle exec exe/debug app.rb`

```
$ bundle exec exe/debug app.rb 
Suspended by: Breakpoint at app.rb:1
[1, 6] in app.rb
=> 1| def fib(num)
    2|   if num < 2
    3|     num
    4|   else
    5|     fib(num-1) + fib(num-2)
    6|   end
(debug) break 5
Breakpoint added: app.rb:5
(debug) continue
Suspended by: Breakpoint at app.rb:5
[1, 10] in app.rb
    1| def fib(num)
    2|   if num < 2
    3|     num
    4|   else
=>  5|     fib(num-1) + fib(num-2)
    6|   end
    7| end
    8| 
    9| a = fib(6)
    10| b = fib(7)
(debug) 
```

### `binding.debug`

To many Ruby devs, a more familiar usage would be adding breakpoints directly in the program, like `binding.pry` or `binding.irb`.

This debugger comes with `binding.debug` for such usages too:

```rb
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
```

```
$ bundle exec ruby app.rb 
[3, 12] in app.rb
     3| def fib(num)
     4|   if num < 2
     5|     num
     6|   else
 =>  7|     binding.debug
     8|     fib(num-1) + fib(num-2)
     9|   end
    10| end
    11| 
    12| a = fib(6)
(debug) next
[4, 13] in app.rb
     4|   if num < 2
     5|     num
     6|   else
     7|     binding.debug
 =>  8|     fib(num-1) + fib(num-2)
     9|   end
    10| end
    11| 
    12| a = fib(6)
    13| b = fib(7)
(debug) 
```
