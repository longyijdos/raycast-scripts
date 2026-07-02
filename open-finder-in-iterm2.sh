#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open in iTerm2
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️
# @raycast.packageName Finder Dev Tools

# Documentation:
# @raycast.description Open selected Finder item or front Finder window in iTerm2

item=$(osascript <<'APPLESCRIPT'
tell application "Finder"
    set selectedItems to selection

    if selectedItems is not {} then
        set itemRef to item 1 of selectedItems
        return POSIX path of (itemRef as alias)
    end if

    if (count of Finder windows) > 0 then
        set currentFolder to target of front window
        return POSIX path of (currentFolder as alias)
    end if

    return ""
end tell
APPLESCRIPT
)

if [ -z "$item" ]; then
    echo "Nothing to open"
    exit 0
fi

if [ -d "$item" ]; then
  dir="$item"
else
  dir="$(dirname "$item")"
fi

osascript - "$dir" <<'APPLESCRIPT'
on run argv
  set targetPath to item 1 of argv

  tell application "iTerm2"
    activate
    create window with default profile command "/bin/sh -c " & quoted form of ("cd " & quoted form of targetPath & " && exec \"${SHELL:-/bin/zsh}\" -l")
  end tell
end run
APPLESCRIPT

echo "Opened in iTerm2"
