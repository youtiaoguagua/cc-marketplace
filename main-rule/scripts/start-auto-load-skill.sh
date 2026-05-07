#!/bin/bash

SKILL_FILE="$(dirname "$0")/../skills/basic-rule/SKILL.md"

# 读取 SKILL.md 内容
SKILL_CONTENT=$(cat "$SKILL_FILE" 2>/dev/null || echo "")

if [ -z "$SKILL_CONTENT" ]; then
  exit 0
fi

# 提取 name（从 frontmatter 中）
NAME=$(echo "$SKILL_CONTENT" | sed -n '/^---$/,/^---$/p' | grep "^name:" | head -1 | sed 's/^name:\s*//')

# 移除 frontmatter（--- 到 --- 之间的内容，包括 ---）
CONTENT_NO_FRONTMATTER=$(echo "$SKILL_CONTENT" | sed '/^---$/,/^---$/d')

# 构建 additionalContext：先显示 name 被加载，然后空一行，再显示内容
if [ -n "$NAME" ]; then
  FULL_CONTEXT="skill $NAME, \n\n$CONTENT_NO_FRONTMATTER"
else
  FULL_CONTEXT="$CONTENT_NO_FRONTMATTER"
fi

# 转义为 JSON 字符串
ESCAPED_CONTENT=$(echo "$FULL_CONTEXT" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

# 输出 JSON
cat << EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "systemMessage": "basic-rule skill automatically loaded.",
    "additionalContext": "$ESCAPED_CONTENT"
  }
}
EOF
