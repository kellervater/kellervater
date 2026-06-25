# Hi, I'm Patrick 👋

**Senior Software Engineer, Infrastructure** @ [Camunda](https://camunda.com)
📍 Austria · 🌐 Remote

_I build the platform, automation, and guardrails that make 100+ engineers faster, and I increasingly set the technical direction behind them._

I'm a platform engineer with a programming background. I started as a Java developer building tools in the financial and public-services sectors, then deliberately moved deeper into the infrastructure stack: from application code to CI/CD pipelines, to containerizing microservices, to building entire Kubernetes platforms from bare metal up. Today I think like a programmer when solving infrastructure problems. I write reusable frameworks, design self-service abstractions, and ship end-to-end with minimal oversight, so the leverage lands on the whole organization, not just my own tickets.

I am a strong advocate for an **async-first workstyle**, valuing deep work, transparent group communication, and respecting others' time over synchronous interruptions (when plannable).
Currently I'm building out my personal OS to become more data-driven and efficient with everyday chores and planning, across both my private and professional life.

### 🔧 What I do at work
Together with the Infra-Team, I own Camunda's developer platform serving **100+ engineers across 10+ product teams**: CI/CD infrastructure (GitHub Actions self-hosted runners on EKS and GKE, label-driven preview environments), Kubernetes clusters (GKE + EKS), container registries (Harbor), dependency management (Renovate), monitoring (Grafana Stack), secret management (HashiCorp Vault), and cross-team platform services. Beyond keeping it running, I set direction for where it goes next. That scope has grown from onboarding individual teams to owning org-wide operations and leading cross-team initiatives.

### ⭐ Selected impact (2024 → today)
- **Owned the Zeebe benchmark platform migration end-to-end** across multiple iterations (GKE, Prometheus/Grafana, Harbor, Teleport RBAC, and cross-cloud GCP↔AWS networking), then handed it back to the owning team with docs, smoke tests, and self-service access.
- **Drove developer-platform cost (FinOps) work**: built per-PR CI cost analysis and a savings roadmap, and turned it into a tracked backlog of concrete reductions to be implemented by multiple teams.
- **Led the org-wide response to the Axios supply-chain compromise**: coordinated rotation of **400+ secrets across ~20 repositories** and multiple teams, then re-architected credential management onto dedicated, Terraform-managed, least-privilege identities so a leaked secret no longer has org-wide blast radius and rotation is a single `terraform apply`.
- **Set technical direction**: introduced the team's ADR process and authored the cross-team *Reduce Developer Toil* roadmap, planning velocity work for the whole team rather than just myself.
- **Scaled my impact through AI-assisted engineering**: authored and shared reusable Copilot/Claude *skills* and agentic workflows adopted across the team, and helped drive the organization's AI-first tooling direction.
- **Modernized the platform with zero downtime**: org-wide Kubernetes upgrades, node-pool migrations, shared cluster operators, and an ingress migration, all without disrupting the teams on top.

### 📄 [Full Resume →](RESUME.md)

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
Languages      Go · Java · TypeScript · Python · Shell · Rust (early stage)
Databases      PostgreSQL · MySQL · MongoDB · Neo4j · Redis
3D/CAD         OpenSCAD (and the BOSL2 lib) · Fusion 360
Coding Agents  GitHub Copilot · Claude
```

### 📫 Get in touch
- 💼 [LinkedIn](https://www.linkedin.com/in/patrickpoetz)
- 📧 kellervater@gmail.com
- ▶️ [YouTube](https://www.youtube.com/@kellerlabs)
