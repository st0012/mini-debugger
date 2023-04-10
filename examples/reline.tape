Output examples/reline.gif

# Avoid showing any early setup errors/warnings
Hide

Set FontSize 20
Set Width 1200
Set Height 700
Set PlaybackSpeed 0.5

# Wait for errors/warnings to clear up
Sleep 500ms
Show

Type "ruby examples/reline.rb"
Enter
Sleep 500ms

Set TypingSpeed 0.05

Type  "foo"
Enter
Sleep 500ms

Type  "bar"
Enter
Sleep 500ms

Type  "exit"
Enter
Sleep 500ms