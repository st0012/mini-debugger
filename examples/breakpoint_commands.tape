Output examples/breakpoint_commands.gif

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

Type "bundle exec ruby app.rb"
Enter
Sleep 800ms

Type "break 8"
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

Type "break 6"
Enter
Sleep 500ms

Type "break"
Enter
Sleep 1000ms

Type "delete 0"
Enter
Sleep 500ms

Type "continue"
Enter
Sleep 500ms

Type "num"
Enter
Sleep 500ms

Type "exit"
Enter
Sleep 500ms