Output examples/step_over.gif

# Avoid showing any early setup errors/warnings
Hide

Set FontSize 20
Set Width 1200
Set Height 600
Set PlaybackSpeed 0.5

# Wait for errors/warnings to clear up
Sleep 500ms
Show

Type "bundle exec ruby app.rb"
Enter
Sleep 500ms

Type "next"
Enter
Sleep 500ms

Type "next"
Enter
Sleep 1000ms

Type "step"
Enter
Sleep 500ms

Type "num"
Enter
Sleep 500ms

Type "continue"
Enter
Sleep 500ms
