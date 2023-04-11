Output examples/result.gif
Require bat

# Avoid showing any early setup errors/warnings
Hide

Set FontSize 20
Set Width 1200
Set Height 600
Set Theme "3024 Day"

# Wait for errors/warnings to clear up
Sleep 500ms
Show

Type "bat --theme=gruvbox-light lib/debugger.rb"
Enter
Sleep 500ms

Down 190

Sleep 1000ms