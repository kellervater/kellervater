---
name: house-style
description: House style for every piece of externally-visible written output. PR/issue descriptions, GitHub comments and reviews, Slack messages and drafts, commit messages. Covers brevity per surface, no em dashes, no process narration, and Slack mrkdwn formatting. Load this BEFORE drafting or submitting a PR, issue, GitHub comment, or Slack draft, not after, and not only when a draft "feels" long or informal.
---

# House style

Patrick reads all of this himself, often under time pressure. The rule across every surface:
**capture the outcome and how to act on it. Never the process of getting there.**

## The one question that catches most violations

Before submitting any PR/issue body, GitHub comment, or Slack message, ask: does this sentence
describe what changed, why it exists, or how to use/test/review it, or does it describe what I
(the agent) assumed, discovered, second-guessed, or changed my mind about mid-task? The second
category is banished, always, even when true, even when it reads as useful engineering context.
"A wrong assumption I caught while building this" is not a "why," it is process narration. Save
it for chat, if anywhere.

## Mechanical checks

Before calling any tool that posts text externally (`gh pr create`, `gh pr edit`,
`gh api ... -F body=`, `gh issue create/comment`, the GitHub MCP tools, Slack draft tools),
proofread the draft yourself:

1. No em dash (—). Recast with a comma, colon, parentheses, or a separate sentence. No en dash
   (–) as a substitute either, a plain hyphen is fine in compounds and ranges.
2. No section headed by (or containing) narration of the drafting process itself.

There is no automated backstop for these right now, only this skill's judgment, applied every
time, not just when a draft "feels" long or informal.

## Per surface

- **Chat, Slack, commit messages:** executive summary only. Offer to expand rather than
  inlining depth.
- **Replies to requesting teams** (`#ask-infra`, any client-facing answer to another team):
  status, link, a concrete ask back. Cut the analysis entirely, don't summarise it, don't
  justify the approach. The linked issue/PR already holds the reasoning. End on a question that
  puts the next move on them (a due date, a priority call), not on our own explanation.
- **Investigation write-ups for Slack** (incidents, root-cause digs, for *our own* channels):
  lead with a short TL;DR (verdict, recommended action, what happens next), full analysis below
  as backing evidence. This is the one Slack surface where depth below the fold is welcome.
- **PR/issue descriptions:** short What / Why / How, related links, only explanations that
  genuinely complement the diff. Scale prose to the size of the diff, not the effort spent.
  Process narration (what was assumed, discovered, or second-guessed mid-task) never belongs
  here, it goes in chat. For material a reader may genuinely need but that would break the flow
  of the main read (verification logs, full command output, a long list of test runs), use best
  judgment: fold it into a `<details>` block rather than either dumping it inline or cutting it
  outright. A `<details>` block is a tool for keeping the executive summary fluent while still
  keeping the evidence attached to the PR, not something to avoid.
- **Repo docs:** document only what stops someone breaking something. Keep the constraint that
  breaks if violated, the reason for a surprising choice, genuine traps. Cut nice-to-have
  observations and mechanism explanations even when accurate. After drafting, delete every line
  that doesn't change a reader's action.
- **ADRs:** terse bullets, not prose. Consequences section is 3-4 short bullets.
- **Code comments:** at most one line, current-state only, only when genuinely non-obvious (a
  hidden constraint, a subtle invariant), never a comparison to a prior approach or a citation of
  a past incident/PR ("built with X, not Y, because <past bug>": just state the current
  invariant). A README's dedicated Why section is the one legitimate place for "X because Y
  would have this problem" reasoning, and even there, state the general constraint rather than
  citing a specific past PR/incident.

**Emoji make text scannable, so use them.** Lead every heading with one; sprinkle a few through
body text where they aid the eye. Applies to Slack, PR descriptions, repo docs. Match the
existing glyph for a section type (`## 📌 What`, `## 🤔 Why`, `## 🔧 How`, `## 📚 References`)
rather than inventing a new one. Roughly one per heading plus the occasional inline accent, don't
emoji every bullet.

## GitHub specifics

- **PR/issue titles:** derive fresh from the current diff/commit. Don't reuse a title string
  from an earlier PR/commit in the same session, even as a starting template. Check "does this
  title describe the file(s) I just diffed?" before submitting.
- **Reviewers:** never auto-add via `--reviewer`/`requested_reviewers`. Patrick requests reviews
  himself via the team's Slack review-request flow when he's ready. Open PRs without reviewers.
- **New issues:** always ask first, in any org, before calling the issue-creation tool, even
  inside repos where PRs proceed without asking. Propose title + one-line purpose (or a full
  draft if wording matters) and wait for an explicit go-ahead. If a specific instruction to open
  one was already given ("open an issue for that"), that is the go-ahead, don't draft and then
  ask "shall I proceed?" a second time.
- **PRs and comments inside a trusted org:** proceed directly, no draft-and-wait step. Outside a
  trusted org: draft and show first, wait for go-ahead.

## Slack specifics

- **Always draft, never send.** Any request to draft/prepare/announce/forward a message for a
  channel means a real Slack draft via the draft-creation tool, never a direct send, never
  pasting the text into the chat reply as the deliverable. Approval-sounding phrases about a
  draft ("fire the draft", "go ahead with the draft", "send the draft") all mean *put that draft
  into Slack*, not *send it live*: only an explicit "post it for real" means a live send. When
  referring a requester to another team, address the requester and point them at the team
  channel; don't address the team directly.
- **mrkdwn, not markdown.** Slack does not render standard markdown:
  - Bold is a single `*asterisk*` pair, double asterisks render literally.
  - Italic is `_underscores_`.
  - No `#` headings. A "heading" is an emoji plus bold text on its own line, with its first
    bullet on the very next line (no blank line between them). One blank line separates blocks.
  - Bullets are literal glyphs, not `-`/`*`: top level `•  `, second `    ◦  `, third
    `        ▪︎  `.
  - Links are `<url|label>`, not `[label](url)`.
  - Check custom emoji names with a search tool before using an unfamiliar one, an unknown
    `:name:` renders as literal text. Standard Unicode emoji always work.
