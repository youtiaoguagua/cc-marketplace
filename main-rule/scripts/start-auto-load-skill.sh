#!/bin/bash

SKILL_FILE="$(dirname "$0")/../skills/basic-rule/SKILL.md"

# Read SKILL.md content
SKILL_CONTENT=$(cat "$SKILL_FILE" 2>/dev/null || echo "")

if [ -z "$SKILL_CONTENT" ]; then
  exit 0
fi

# Extract name from frontmatter
NAME=$(echo "$SKILL_CONTENT" | sed -n '/^---$/,/^---$/p' | grep "^name:" | head -1 | sed 's/^name:\s*//')

# Remove frontmatter (content between --- lines, inclusive)
CONTENT_NO_FRONTMATTER=$(echo "$SKILL_CONTENT" | sed '/^---$/,/^---$/d')

# Build context: show loaded name + two literal newlines + content
if [ -n "$NAME" ]; then
  FULL_CONTEXT="skill $NAME, \n\n${CONTENT_NO_FRONTMATTER}"
else
  FULL_CONTEXT="$CONTENT_NO_FRONTMATTER"
fi

# Output JSON using jq for safe escaping
echo "$FULL_CONTEXT" | jq -Rs '{
  hookSpecificOutput: {
    hookEventName: "SessionStart",
    systemMessage: "basic-rule skill automatically loaded.",
    additionalContext: .
  }
}'
