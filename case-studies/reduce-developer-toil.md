# ⚡ Reduce Developer Toil

## 🧭 Context

The Infra team maintains a large shared infrastructure codebase: dozens of Kubernetes components across AWS and GCP dev, stage and prod clusters, kept current by Renovate. Several engineers and, increasingly, AI agents change the same dev clusters at the same time.

## 🧩 Problem

Maintenance ate engineering time. Dependency updates needed a human to check each one, upgrades broke in ways nobody noticed until stage, people overwrote each other's experiments on shared dev infrastructure, and temporary workarounds for upstream bugs outlived the bugs. Reactive work won every priority call because nobody measured it.

## 🔧 What I did

I wrote the strategy, pitched it, and now run it as a program with a roadmap and sub-epics. Shipped so far:

- **PR-lifetime leases for shared dev infrastructure.** From proposal posts and a decision record to resource markers with linting, a lease CLI, enforcement in the apply targets and in CI smoke tests, and a read-only lease board. Rolled out opt-in with walkthroughs, and presented to the wider department. Leases are the precondition for many humans and agents working on dev at once.
- **A component-test framework that gates automerge.** One trigger-driven framework on AWS and GCP dev clusters tests real behaviour after each upgrade, and Renovate automerges patch and minor updates once those tests pass, for a dozen core components (certificate management, secrets sync, scanners, ingress, operators, monitoring). A companion skill generates new component tests from how a component is actually used across the codebase, so anyone can close a coverage gap.
- **An agent that retires workarounds.** Temporary workarounds get a structured marker tied to an upstream issue or release; an agent running in CI checks them and opens the removal PR once the fix lands. It runs on a GitHub App without personal tokens and covers 16 repositories, open to any team.

## 📈 Outcome

- Routine component updates merge after passing real tests, without waiting for a human.
- Engineers and agents no longer clash on shared dev infrastructure.
- Workaround debt is retired automatically as upstream fixes land.

## 🔭 In progress

Agent access to dev infrastructure so an AI maintenance role can analyse upgrade impact, generate missing tests and propose fixes, with the human DRI reviewing. The next step is measuring the program: the share of team time spent on reactive work, reported monthly.

## 🌐 Reach beyond my team

The workaround agent runs in repositories beyond the Infra codebase, and the program sets the direction for how the team adopts agent-driven workflows.
