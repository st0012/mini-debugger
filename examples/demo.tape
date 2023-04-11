Output examples/demo.gif

# Avoid showing any early setup errors/warnings
Hide

Set FontSize 30
Set Width 1200
Set Height 600
Set PlaybackSpeed 0.5
Set Theme "3024 Day"

# Wait for errors/warnings to clear up
Sleep 500ms
Show

Type "bundle exec exe/debug app.rb"
Enter
Sleep 1000ms

Type "break 9"
Enter
Sleep 1000ms

Type "continue"
Enter
Sleep 1000ms

Type "next"
Enter
Sleep 1000ms

Type "step"
Enter
Sleep 1000ms

Type "num"
Enter
Sleep 1000ms

Type 'puts "num: #{num}"'
Enter
Sleep 1000ms

Type "break"
Enter
Sleep 500ms

Type "delete 0"
Enter
Sleep 500ms

Type "continue"
Enter
Sleep 500ms