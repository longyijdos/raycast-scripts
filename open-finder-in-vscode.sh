#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open in VS Code
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🧩
# @raycast.packageName Finder Dev Tools

# Documentation:
# @raycast.description Open selected Finder items or front Finder window in VS Code

paths=$(osascript <<'APPLESCRIPT'
tell application "Finder"
    set selectedItems to selection

    if selectedItems is not {} then
        set pathText to ""

        repeat with itemRef in selectedItems
            set pathText to pathText & POSIX path of (itemRef as alias) & linefeed
        end repeat

        return pathText
    end if

    if (count of Finder windows) > 0 then
        set currentFolder to target of front window
        return POSIX path of (currentFolder as alias)
    end if

    return ""
end tell
APPLESCRIPT
)

if [ -z "$paths" ]; then
    exit 0
fi

echo "$paths" | while IFS= read -r item; do
  [ -z "$item" ] && continue
  open -a "Visual Studio Code" "$item"
done

echo "Opened in VS Code"
