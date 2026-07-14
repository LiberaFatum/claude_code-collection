# <repo-name> — codemap

> Last updated: YYYY-MM-DD HH:MM UTC by codemap skill (<short reason — e.g. "manual refresh", "after auth rewrite">)
> File count: <N> src / <M> test | LOC: ~<K> <primary-language>

## Quick orient

<2–4 sentences. What this app does, for whom, where it's deployed, live URL if public. No marketing.>

<!-- OPTIONAL — include only if there is genuinely-relevant in-flight state -->
**Current state (YYYY-MM-DD):** <e.g. "mid migration from X to Y; DB wiped frequently", "feature freeze for v1 release">

## Stack

- **Backend**: <runtime + framework + version>
- **Frontend**: <framework + version, or "n/a">
- **DB**: <engine + version + notable extensions>
- **Infra / deploy**: <Railway / Vercel / k8s / bare metal>
- **Tests**: <runner + rough count, e.g. "Vitest, 591 passing across 22 packages">
- <other load-bearing tooling — LLM SDK, queue, cache>

## Directory tree

```
<repo-name>/
├── apps/ or src/        <one-liner>
│   ├── <subdir>/        <one-liner>
│   └── ...
├── packages/ or lib/    <one-liner>
│   └── ...
├── infra/               <one-liner>
└── CODEMAP.md           This file
```

<!-- 2 levels deep is usually right. 3 only if the second level is huge (e.g. monorepo `packages/`). -->

## Apps / services

### <app-name> — <one-line role>

<2–6 sentences on what this app does that you can't see from the tree. Entry point, key routes/commands, anything that would surprise a reader.>

<!-- Repeat per app/service. Skip this whole section for single-binary repos. -->

## Pipeline / domain logic

<Only if there is a non-obvious multi-step flow. Otherwise omit. Use a table or numbered list.>

| step | does what | code |
|---|---|---|
| 1 | … | `packages/foo/src/bar.ts` |
| 2 | … | … |

## Schema

<Only if there is a DB / persistent store. Table of tables/collections.>

| table | purpose |
|---|---|
| `users` | … |
| `…` | … |

<!-- Mention recently-dropped tables with one-line reason — saves a future session from re-introducing them. -->

## Notable subsystems

<Free-form short subsections for parts of the code that are load-bearing but not obvious. Each one should answer: "what would I get wrong if I changed this without context?">

### <subsystem name>

<3–8 sentences. Why it exists, what's tricky, what other code depends on its invariants.>

## Gotchas

<Bulleted list of things that bit someone, or decisions that look weird but are intentional. Highest-value section for orientation.>

- <thing>: <why it's that way; what breaks if you "fix" it>
- …

## See also

- <pointer to README, ADRs, runbooks, dashboards — only if they exist and are current>
