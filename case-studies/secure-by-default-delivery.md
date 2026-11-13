# 🔐 Secure-by-default delivery

## 🧭 Context

Camunda's CI runs across hundreds of repositories in several GitHub organisations, on self-hosted and GitHub-hosted runners. Most pipelines read secrets from a central secrets manager, and the platform pulls third-party actions, container images and dependencies every day.

## 🧩 Problem

CI access to secrets had grown around one broad, long-lived credential: any pipeline that held it could read far more than it needed. Third-party actions and images were referenced by mutable tags. When supply-chain attacks hit the ecosystem, these two properties are what turn one compromised dependency into an org-wide rotation effort.

## 🔧 What I did

- **Led the Infra side of the incident response.** Built an exposure analyzer that cross-checks workflow definitions against secrets-manager audit logs to find what was actually reachable, wrote a prioritised rotation playbook with an owner per credential, and coordinated the teams through it. Every critical credential was rotated within a week.
- **Made rotation cheap.** Replaced shared registry credentials with scoped, Terraform-managed and ephemeral ones, so a rotation is now a `terraform apply`.
- **Removed the broad credential.** Designed team-scoped, least-privilege policies, removed secrets access from repositories that never used it, and migrated 100+ repositories in staged waves. A transitive usage scanner found secrets consumed inside third-party actions and reusable workflows.
- **Moving to keyless.** Leading the migration from long-lived credentials to OIDC-based authentication across the org, driven by inventory and transform tooling: 50+ repositories in the first weeks, rollout ongoing.
- **Pinned and enforced the supply chain.** SHA-pinned every third-party action with enforced workflow linting, and pinned every deployed container image by digest, kept current by Renovate.
- **Took backups out of the blast radius.** Moved secrets-manager backups outside the manager's own trust domain: encrypted archives under two independent keys, daily and monthly retention, freshness alerting, and a restore drill with a runbook. I reworked the design after a security review challenged its first premise, and wrote it down as a decision record.

## 📈 Outcome

- A leaked CI credential no longer reaches every product's secrets; access follows team ownership.
- Credential rotation went from a coordinated manual effort to an apply.
- Pinned dependencies and linted workflows make a malicious upstream change visible in review before it runs.
- Backups survive a compromise of the system they protect, and restores are tested.

## 🌐 Reach beyond my team

Every product team using secrets in CI migrated onto the new model, most through PRs I prepared for them. I published [`vault-wrapped-secrets`](https://github.com/camunda/infra-global-github-actions/tree/main/vault-wrapped-secrets) in our public actions repository so any job, including AI agent jobs, can receive secrets without ever holding credentials. The work turned me into the Infra security DRI: the entry point for security topics from InfoSec and other teams.
