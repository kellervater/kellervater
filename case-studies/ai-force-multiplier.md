# 🤖 AI as a force multiplier

## 🧭 Context

Platform teams answer the same kinds of requests over and over, and the knowledge to do them well lives in a few heads. Coding agents can do much of this work, if they know how the platform actually works and can act safely.

## 🧩 Problem

AI use on the team started as individual habits. Agents lacked the operational context to be trusted, and giving them real credentials was not acceptable.

## 🔧 What I did

- **Encoded runbooks as agent skills.** Registry onboarding, secrets onboarding, Terraform-managed secret migration, CI cost analysis, dev testing, disruption-free node-pool migration, component-test generation and workaround markers, so any teammate or agent follows the same proven procedure.
- **Dispatched work from the request itself.** Agent-authored PRs triggered straight from support requests and alert threads, reviewed by a human.
- **Kept credentials away from agents.** Published [`vault-wrapped-secrets`](https://github.com/camunda/infra-global-github-actions/tree/main/vault-wrapped-secrets), which hands a job single-use wrapped secrets so agent jobs never hold secrets-manager credentials.
- **Automated team reporting.** An issue summarizer that extracts deliverables from issue activity, generated daily stand-ups, and a newsletter skill with a team registry and statistics collector, which produced a company-wide edition and became the team's handover process for that role.
- **Built the groundwork for agent fleets.** Leases on shared dev infrastructure and component tests (see [Reduce Developer Toil](reduce-developer-toil.md)) let agents and humans change the same environment safely.

## 📈 Outcome

Skills carry operational knowledge beyond the person who wrote them, routine requests turn into reviewed PRs quickly, and agents get the access they need without the credentials they must not hold.

## 🌐 Reach beyond my team

The skills serve requests from any team, the wrapped-secrets action is public, and the newsletter skill moved with its role to a teammate.
