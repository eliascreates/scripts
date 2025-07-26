#!/usr/bin/env bash
#
# doki — your dev diary, at the speed of thought.
# Usage: doki [topic] [--new|-n] [--open|-o] [--help|-h]

NOTES_DIR="$HOME/dev/notes"
DATE=$(date +"%Y-%m-%d")
TIMESTAMP=$(date +"%Y-%m-%dT%H-%M-%S")
TIMESTAMP_DISPLAY=$(date +"%Y-%m-%dT%H:%M:%S")
NEW_FLAG=false
OPEN_FLAG=false
TOPIC=""

show_help() {
  cat <<EOF

📓 doki — your heartbeat in notes

Usage:
  doki [topic]             Show or create today's note in "topic/"
  doki --new|-n [topic]    Force a new note with full ISO timestamp
  doki --open|-o [topic]   Open the most recent note in topic (or random/)
  doki --help|-h           Show this help

Examples:
  doki                     → help
  doki flutter             → open/create today's flutter note
  doki postgres -n         → new postgres note even if one exists today
  doki -n                  → new random note
  doki -o work             → open most recent work note
  doki --open              → open most recent random note

EOF
}

# If no arguments, just show help and exit
if [[ $# -eq 0 ]]; then
  show_help
  exit 0
fi

# Parse flags (order doesn’t matter)
while (( "$#" )); do
  case "$1" in
    -n|--new)  NEW_FLAG=true; shift ;;
    -o|--open) OPEN_FLAG=true; shift ;;
    -h|--help) show_help; exit 0 ;;
    *)
      if [[ -z "$TOPIC" ]]; then
        TOPIC=$1
        shift
      else
        echo "❌ Unexpected argument: $1"
        show_help
        exit 1
      fi
      ;;
  esac
done

# Default topic → random
TOPIC=${TOPIC:-random}
TOPIC_DIR="$NOTES_DIR/$TOPIC"
mkdir -p "$TOPIC_DIR"

# OPEN logic: open the most recent file in the topic
if [[ "$OPEN_FLAG" == true ]]; then
  LATEST=$(find "$TOPIC_DIR" -maxdepth 1 -type f | sort | tail -n 1)
  if [[ -z "$LATEST" ]]; then
    echo "⚠️  No notes found in $TOPIC_DIR"
    exit 1
  fi
  echo "📂 Opening latest note: $(basename "$LATEST")"
  "${EDITOR:-nvim}" "$LATEST"
  exit 0
fi

# NEW or default (open/create today) logic:
if [[ "$NEW_FLAG" == true ]]; then
  TARGET="$TOPIC_DIR/${TIMESTAMP}.md"
else
  TODAY_LATEST=$(find "$TOPIC_DIR" -maxdepth 1 -type f -name "${DATE}T*.md" | sort | tail -n 1)
  if [[ -n "$TODAY_LATEST" ]]; then
    TARGET="$TODAY_LATEST"
  else
    TARGET="$TOPIC_DIR/${TIMESTAMP}.md"
  fi
fi

# Create with template if it doesn't exist
if [[ ! -f "$TARGET" ]]; then
  cat > "$TARGET" <<EOF
# ${TOPIC^} Note – $TIMESTAMP_DISPLAY

> 📅 Date: $TIMESTAMP_DISPLAY
> 🏷️ Tags: #$TOPIC #learning #dev  

---

## 🌱 What I Learned

- 

## 🧠 Concepts

- 

## 🔧 Code Snippets

\`\`\`
\`\`\`

## 💭 Reflections

- 

---
EOF
  echo "✨ Created new note: $(basename "$TARGET") under topic '$TOPIC'"
else
  echo "🔄 Opening existing note: $(basename "$TARGET") under topic '$TOPIC'"
fi

"${EDITOR:-nvim}" "$TARGET"
