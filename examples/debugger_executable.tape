Output examples/debugger_executable.gif

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
Sleep 700ms

Type "break 5"
Enter
Sleep 500ms

Type "continue"
Enter
Sleep 500ms

Type "num"
Enter
Sleep 500ms

Type "continue"
Enter
Sleep 500ms

Type "num"
Enter
Sleep 500ms

Type "delete 0"
Enter
Sleep 500ms

Type "continue"
Enter
Sleep 500ms