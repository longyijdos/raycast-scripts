#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Path
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📋
# @raycast.packageName Finder Dev Tools

# Documentation:
# @raycast.description Copy selected Finder item paths or front Finder window path

paths=$(osascript <<'APPLESCRIPT'
tell application "Finder"
    set selectedItems to selection

    if selectedItems is not {} then
        set pathText to ""

        repeat with itemRef in selectedItems
            set pathText to pathText & POSIX path of (itemRef as alias) & linefeed
        end repeat

        set the clipboard to pathText
        return pathText
    end if

    if (count of Finder windows) > 0 then
        set currentFolder to target of front window
        set folderPath to POSIX path of (currentFolder as alias)
        set the clipboard to folderPath
        return folderPath
    end if

    return ""
end tell
APPLESCRIPT
)

if [ -z "$paths" ]; then
    echo "Nothing to copy"
    exit 0
fi

echo "Copied path"
