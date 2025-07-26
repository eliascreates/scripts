#!/usr/bin/env bash
#
# generate-index.sh — build a master index.md for all your doki notes

NOTES_DIR="$HOME/dev/notes"
INDEX_FILE="$NOTES_DIR/index.md"

# Header
cat > "$INDEX_FILE" <<EOF
# 📚 Dev Notes Index

_Last generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")_

EOF

# Loop over each topic folder
for TOPIC_PATH in "$NOTES_DIR"/*/; do
  TOPIC=$(basename "$TOPIC_PATH")
  # Skip the index file itself if it’s accidentally in a folder
  [[ ! -d "$TOPIC_PATH" ]] && continue

  echo -e "## ${TOPIC^}\n" >> "$INDEX_FILE"

  # List all .md files sorted ascending (or reverse for most recent first)
  find "$TOPIC_PATH" -maxdepth 1 -type f -name "*.md" \
    | sort \
    | while read -r FILE; do
        NAME=$(basename "$FILE")
        REL_PATH="./$TOPIC/$NAME"
        echo "- [$NAME]($REL_PATH)" >> "$INDEX_FILE"
      done

  echo "" >> "$INDEX_FILE"
done

echo "✅ Generated index at $INDEX_FILE"
