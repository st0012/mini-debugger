# mini-debugger

This is a complemantry repo for my talk `Build a mini Ruby debugger in under 300 lines`.

## Requirements

- Ruby `3.1+`
- `reline`
  - Should be bundled with Ruby, but you can also install it with `gem install reline`

## Usages

### `bin/debug` executable

`bin/debug my_ruby_script.rb` executes the script with the toy-debugger enabled:

```
$ bin/debug app.rb
Debugger is loaded
Breakpoint at app.rb:1 is activated
Suspended by: Breakpoint at app.rb:1
[1, 6] in app.rb
 => 1| load "./lib.rb"
    2|
    3| s = "Debugging"
    4| f = Foo.new
    5| result = f.bar(s)
    6| binding.debug
(debug)
```

The debugger will stop at the program start to let users add breakpoints for later debugging.

This is similar to what `rdbg` does:

```
$ rdbg app.rb
[1, 7] in app.rb
=>   1| load "./lib.rb"
     2|
     3| s = "Debugging"
     4| f = Foo.new
     5| result = f.bar(s)
     6| binding.debug
     7| puts(result)
=>#0    <main> at app.rb:1
(rdbg)
```

### `binding.debug`

To many Ruby devs, a more familiar usage would be adding breakpoints directly in the program, like `binding.pry` or `binding.irb`.

This debugger comes with `binding.debug` for such usages too:

```rb
# test_breakpoint.rb
require "debugger"
a = 1
b = 2
binding.debug
c = 3
d = 4
puts a + b + c + d
```

```
$ ruby -Ilib test_breakpoint.rb
Debugger is loaded
[1, 9] in test_breakpoint.rb
    2|
    3| a = 1
    4| b = 2
 => 5| binding.debug
    6| c = 3
    7| d = 4
    8|
    9| puts a + b + c + d
(debug)
```

### Commands

- `break` - list all breakpoints.
  - `break <line>` - add a breakpoint at `<line>` of the current file.
  - `break <file>:<line>` - add a breakpoint at the specified location.
- `delete <id>` - delete the specified breakpoint.
- `s[tep]` - step in. Continue the program until the next stoppable point.
- `n[ext]` - step over. Continue the program until the next line.
- `c[ontinue]` - continue the program.
- `exit` - exit the program.
