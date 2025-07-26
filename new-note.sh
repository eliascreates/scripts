#!/bin/bash

# Location of notes
NOTES_DIR="$HOME/dev/notes/random"

# Today's date
TODAY=$(date +%Y-%m-%d)

# File path
FILE="$NOTES_DIR/$TODAY.md"

# If file already exists, open it
if [ -f "$FILE" ]; then
    nvim "$FILE"
    exit 0
fi

# Otherwise, create it with a template
cat <<EOF > "$FILE"
# Daily Note – $TODAY

> 📅 Date: $TODAY  
> 🏷️ Tags: #daily #learning  

---

## 🌱 What I Learned

- 

## 🧠 Concepts

- 

## 🔧 Code Snippets

\`\`\`csharp
// Code here
\`\`\`

## 💭 Reflections

- 

---
EOF

nvim "$FILE"
