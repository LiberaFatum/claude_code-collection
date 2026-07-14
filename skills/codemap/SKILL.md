---
name: codemap
description: Create or refresh a CODEMAP.md — a single-file orientation document a fresh Claude session can read to understand a codebase (stack, directory tree, key subsystems, schema, gotchas). Use when the user asks to "create/write/generate a codemap", "refresh/update the codemap", "make a fresh-session orientation doc", or invokes /codemap. Run on any repo regardless of language.
---

# CODEMAP

A CODEMAP.md sits at the repo root and is the first thing a new Claude session reads. It is **not** API docs, not a README, not architecture-vision marketing. It is a dense, current snapshot a colleague would actually keep open in a tab.

## Two workflows

### `create` — no CODEMAP.md exists yet

1. Run `scripts/detect.sh <repo-root>` to get file/LOC counts, stack hints, and a 2-level tree.
2. Read the manifest files it reported (`package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `pom.xml`, etc.) to learn frameworks/versions.
3. Spot-read entry points: `apps/*/src/index.*`, `cmd/*/main.go`, `src/main.*`, top-level routers, schema/migration files, the largest package directories.
4. Draft using [TEMPLATE.md](TEMPLATE.md). Fill only the sections that apply — omit empty ones rather than writing "N/A".
5. Write to `<repo-root>/CODEMAP.md`. Show the user a brief diff summary, not the whole file.

### `update` — CODEMAP.md already exists

1. Read the existing CODEMAP.md. Note the "Last updated" line and the file/LOC numbers.
2. Run `scripts/detect.sh` again. Compare:
   - File count / LOC drift > 10 %  → directory tree section likely needs touching
   - New top-level package/app directory → add to tree + write a short subsection
   - Removed directory → remove or mark dropped (with a one-line reason if you know it from `git log`)
3. Run `git log --oneline -30` and read commits since the last-updated timestamp. Anything that is **load-bearing for orientation** (new portal/service, schema change, migration, dropped feature, architectural pivot) is in scope. Cosmetic fixes, dependency bumps, and small refactors are **not**.
4. Edit **only** the sections that changed. Bump the "Last updated" line. Do not rewrite stable sections — diff churn is noise.
5. Show the user the section list you touched and why.

## Hard rules

- **No time-sensitive plumbing.** Never write "as of next week", "check back in May", or roadmap dates. CODEMAP describes what *is*, not what *will be*.
- **No marketing.** "Robust, scalable, modern" → cut. State the framework version and move on.
- **Cite reality, not aspiration.** If a feature is half-built, say so ("WIP — `foo()` returns mock data"). Don't describe the intent.
- **Round/migration history is opt-in.** Only include it if the project already uses that convention (look for "round N" / "Mxx" patterns in `git log`). Otherwise leave it out.
- **Length ceiling: ~250 lines.** If you're past that, you're writing docs not a codemap. Push detail into the actual code.
- **One file only.** No `docs/codemap/*.md` companion files. The whole point is single-file orientation.

## Header format

```
# <repo-name> — codemap

> Last updated: YYYY-MM-DD HH:MM UTC by codemap skill (<short reason>)
> File count: <N> src / <M> test | LOC: ~<K> <primary-lang>
```

The reason string is one-liner context ("manual refresh", "after auth rewrite", "post-M18 portal additions"). It is the first thing a future session sees — make it useful.

## What goes in (priority order)

1. **Quick orient** — 2–4 sentences. What does this app do, for whom, deployed where, live URL if any.
2. **Current state** — what is in flight right now if it materially changes how a new session should behave (e.g., "DB wiped frequently", "migration in progress").
3. **Stack** — language/runtime + framework + DB + deploy target. Versions matter.
4. **Directory tree** — 2 levels deep with one-line purpose per entry. Use a fenced code block.
5. **Per-app or per-service sections** — one short subsection each, focused on *what would surprise a reader who only saw the file tree*.
6. **Domain logic / pipeline** — if there's a non-obvious flow (multi-phase processing, state machine), diagram it in a table or numbered list.
7. **Schema** — table of tables/collections with one-line purpose. Drop dead tables.
8. **Gotchas** — bugs that bit, decisions that look weird but are load-bearing, removed features and *why*. This is the highest-value section for a fresh session.

## Anti-patterns

- Restating the README. If `README.md` says it, link to it instead.
- Auto-generated API tables. If they go stale on every commit, they're worse than nothing.
- Per-file docstrings. Codemap is the *shape* of the codebase, not its contents.
- Emoji status badges. The "Last updated" line plus prose does the job.

## See also

- [TEMPLATE.md](TEMPLATE.md) — fillable skeleton
- [scripts/detect.sh](scripts/detect.sh) — deterministic counts + stack detection
