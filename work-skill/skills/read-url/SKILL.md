---
name: read-url
description: Fetch web content as clean Markdown using Exa, Jina Reader, and WebFetch. Choose the right tool for each scenario.
---

# /read-url — Fetch Web Content as Clean Markdown

Turn any URL into readable Markdown. Three tools, pick the right one.

## Tool Selection

### Exa — `mcp__Exa__crawling_exa`

Primary tool. Clean Markdown extraction with configurable `maxCharacters`.

```
mcp__Exa__crawling_exa
  urls: ["https://example.com/article"]
  maxCharacters: 6000  # default 3000, adjust as needed
```

Also use `mcp__Exa__web_search_exa` for search-first-then-fetch workflows.

### Jina Reader — `r.jina.ai`

Fallback when Exa can't reach the content (paywalled, JS-heavy, blocked).

```
https://r.jina.ai/YOUR_URL
```

Use with `WebFetch`:

```
WebFetch
  url: "https://r.jina.ai/https://example.com/article"
  prompt: "extract the main content..."
```

### Jina Search — `s.jina.ai`

For searching when you need to find pages first, then read them.

```
https://s.jina.ai/YOUR_SEARCH_QUERY
```

### WebFetch

Built-in fallback. Use when Exa and Jina both fail, or for quick single-page fetches.

```
WebFetch
  url: "https://example.com"
  prompt: "extract key information about..."
```

## Decision Flow

```
Can Exa reach it?
  YES → mcp__Exa__crawling_exa
  NO  → Is it JS-heavy / paywalled / blocked?
          YES → https://r.jina.ai/URL via WebFetch
          NO  → WebFetch directly

Need to search first?
  → mcp__Exa__web_search_exa (primary)
  → https://s.jina.ai/QUERY (fallback)
```

## When to Use

- Reading documentation, articles, or references at a URL
- Fetching GitHub READMEs, issues, PRs (prefer `gh` CLI for GitHub)
- Extracting content from paywalled or JS-heavy pages
- Searching the web for information, then deep-reading results

## When NOT to Use

- GitHub API operations → use `gh` CLI
- Local files → use `Read` tool
- Interactive auth-required pages → use specialized MCP tools

## References

- [Jina Reader](https://jina.ai/reader) — `r.jina.ai` for reading, `s.jina.ai` for searching
- Exa MCP tools — `mcp__Exa__crawling_exa`, `mcp__Exa__web_search_exa`
