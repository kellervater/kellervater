# Hi, I'm Patrick 👋

**Senior Software Engineer, Infrastructure** @ [Camunda](https://camunda.com)
📍 Austria · 🌐 Remote

_I build CI/CD platforms that are fast and secure by default, and I turn incidents into structural fixes for the whole engineering org._

I'm a platform engineer with a programming background. I started as a Java developer building tools in the financial and public-services sectors, then deliberately moved deeper into the infrastructure stack: from application code to CI/CD pipelines, to containerizing microservices, to building entire Kubernetes platforms from bare metal up. Today I think like a programmer when solving infrastructure problems. I write reusable frameworks, design self-service abstractions, and ship end-to-end with minimal oversight, so the leverage lands on the whole organization.

I am a strong advocate for an **async-first workstyle**, valuing deep work, transparent group communication, and respecting others' time over synchronous interruptions (when plannable).
Currently I'm building out my personal OS to become more data-driven and efficient with everyday chores and planning, across both my private and professional life.

### 🔧 What I do at work
Together with the Infra team, I run Camunda's developer platform for **100+ engineers across 10+ product teams**: self-hosted GitHub Actions runners on GKE and EKS, preview environments, Kubernetes, container registries, dependency automation, observability and secrets management. My focus is secure software delivery: keyless CI identities, a pinned and tested supply chain, and self-service that keeps product teams unblocked. I own multi-quarter programs end to end, write the decision records other teams build on, and lead the Infra side of security incidents.

### ⭐ Selected impact (2024 → today)
- 🔐 **Secure by default, org-wide:** moved CI secrets access for **100+ repositories** to team-scoped, least-privilege policies and now to keyless OIDC; SHA- and digest-pinned the supply chain with policy enforcement; moved secrets-manager backups outside their own trust domain. Incident lead on the Infra side during industry-wide supply-chain attacks, each one turned into structural hardening. [Case study →](case-studies/secure-by-default-delivery.md)
- ⚡ **Started and run a developer-toil reduction program:** PR-lifetime leases for shared dev infrastructure, a component-test framework that gates dependency automerge, and an agent that retires upstream workarounds once fixes land, across 16 repositories. Agent-driven maintenance is the next stage. [Case study →](case-studies/reduce-developer-toil.md)
- 🏗️ **Led a multi-quarter, cross-team platform migration:** moved a product team's benchmark environment onto isolated, GitOps-managed clusters, then handed it back as self-service. The owning team has since shipped **40+ changes** to it on their own. [Case study →](case-studies/benchmark-platform-self-service.md)
- 🤖 **AI as a team force multiplier:** agent skills that encode our runbooks, agent-authored PRs dispatched from request threads, and [`vault-wrapped-secrets`](https://github.com/camunda/infra-global-github-actions/tree/main/vault-wrapped-secrets), a public action that hands secrets to agent jobs without giving them credentials. [Case study →](case-studies/ai-force-multiplier.md)
- 🧭 **Set technical direction in writing:** introduced decision records for our infrastructure codebase and authored the roadmaps and epics the team executes on.

### 📄 [Full Resume →](RESUME.md) · 📚 [Case studies →](case-studies/)

### 🏗️ What I build for fun

#### [HomeRacker](https://github.com/kellerlabs/homeracker): *A fully modular 3D-printable rack-building system*

[![Stars](https://img.shields.io/github/stars/kellerlabs/homeracker?style=flat&logo=github)](https://github.com/kellerlabs/homeracker)
[![Forks](https://img.shields.io/github/forks/kellerlabs/homeracker?style=flat&logo=github)](https://github.com/kellerlabs/homeracker/network/members)
[![Website](https://img.shields.io/badge/web-homeracker.org-blue)](https://homeracker.org/)
[![Discord](https://img.shields.io/badge/chat-Discord-7289da?logo=discord&logoColor=white)](https://discord.gg/b6myzHRxc3)

I created HomeRacker because I was dissatisfied with existing 3D-printable rack solutions: too specific, too rigid, too many adapters. HomeRacker is a fully parametric, open-spec system that can build anything from a Raspberry Pi mini-rack to a 10"/19" server rack to a bookshelf. It needs no printed supports and no tools for assembly.

- 🎥 [YouTube: Build Guides & Tutorials](https://www.youtube.com/@kellerlabs)
- 🖨️ [Makerworld: Ready-to-Print Models](https://makerworld.com/@kellerlab)
- 🐙 [Community Repo: Extensions & Modules](https://github.com/kellerlabs/homeracker-community)

Also built **[scadm](https://github.com/kellerlabs/homeracker/tree/main/cmd/scadm)** ([PyPi](https://pypi.org/project/scadm/)), a zero-dependency Python package manager for OpenSCAD libraries. `pip install scadm`

### 🛠️ Tech I work with

```
Cloud          GCP · AWS · Azure · Hetzner
Kubernetes     GKE · EKS · Rancher · bare-metal
Virtualization Proxmox
IaC            Terraform · Pulumi (Go) · Kustomize · Ansible
GitOps         ArgoCD · FluxCD
CI/CD          GitHub Actions · Jenkins · Gitlab
Security       Teleport · Vault · WireGuard · Okta · Yubikeys (GPG)
Monitoring     Prometheus · Grafana · OpenTelemetry · Elasticsearch · Opensearch
Languages      Go · Java · TypeScript · Python · Shell
Databases      PostgreSQL · MySQL · MongoDB · Neo4j · Redis
3D/CAD         OpenSCAD (and the BOSL2 lib) · Fusion 360
Coding Agents  GitHub Copilot · Claude
```

### 📫 Get in touch
- 💼 [LinkedIn](https://www.linkedin.com/in/patrickpoetz)
- 📧 kellervater@gmail.com
- ▶️ [YouTube](https://www.youtube.com/@kellerlabs)
