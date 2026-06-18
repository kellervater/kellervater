# Patrick Pötz

**Senior Software Engineer, Infrastructure**
Pöllau, Styria, Austria (Remote - EU)

📧 kellervater@gmail.com · 🔗 [linkedin.com/in/patrickpoetz](https://www.linkedin.com/in/patrickpoetz) · 💻 [github.com/kellervater](https://github.com/kellervater)

---

## Summary

Platform engineer with 16 years of experience — from Java developer in financial systems to infrastructure architect and developer-platform owner. I build software that makes other engineers more productive and increasingly set the technical direction behind it: owning developer platforms, CI/CD, Kubernetes, and cross-team platform services for 100+ engineers across 10+ teams. I operate as a force-multiplier — writing reusable frameworks, designing self-service abstractions, leading cross-team migrations and security incidents, and establishing practices (ADRs, roadmaps, scoped-access models) that other teams adopt. I think like a programmer when solving infrastructure problems and ship end-to-end with minimal oversight. Over the past year I've gone deep on AI coding agents — authoring reusable agent skills and agentic workflows for the team while balancing staying current with the latest models and squeezing real day-to-day efficiency out of them (preferred model: Claude Opus 4.6). Highly efficient in async work (established since the 2020 Covid shift) and an evangelist for an async-first workstyle—prioritizing group chats over DMs and respecting each other's time ("let's hop on a quick chat" are absolute exceptions reserved for incidents).

---

## Experience

### Camunda - Senior Software Engineer, Infrastructure
**June 2024 – Present** · Remote

Own Camunda's developer platform serving 100+ engineers across 10+ product teams — CI/CD infrastructure (GitHub Actions self-hosted runners on EKS, label-driven preview environments), Kubernetes clusters (GKE + EKS), container registries (Harbor), dependency management (Renovate), monitoring (Prometheus/Grafana), secret management (Vault), and cross-team platform services. Increasingly act as a technical-direction setter and force-multiplier across the engineering organization. Scope has grown steadily over my tenure — from onboarding individual product teams onto the platform, to owning org-wide operations, to leading multi-quarter cross-team initiatives and org-wide incident response.

**Technical leadership & direction**
- **DRI for the Zeebe Benchmark Platform Migration** — multi-quarter, four-iteration program migrating an entire team's benchmark infrastructure (GKE cluster, Prometheus/Grafana monitoring, Harbor registry, Teleport RBAC, AWS ECS workloads, cross-cloud GCP↔AWS networking) from a team-owned environment to the centrally managed Infra platform, then handing it back with documentation, smoke tests, and self-service access. Delivered with cross-functional coordination; final ECS-monitoring iteration shipped against a 6-day deadline in 4.
- **Introduced the team's ADR process** to make architectural decisions explicit, reviewable, and durable across the team.
- **Authored the cross-team "Reduce Developer Toil" roadmap** — several weeks of deliberate planning turned into a structured epic and sub-initiatives (PR-lifetime leases, coding-agent access, scoped local access, AI-assisted ask-infra/maintenance), setting developer-velocity direction for the whole team rather than just my own work.
- **Co-shaped team-level technical direction beyond my own projects** — contributed to the team's multi-year technical vision and prototyped an AI-driven "medic" concept to automate incident triage.

**Security & reliability**
- **Led the org-wide response to the Axios supply-chain (RAT) compromise** — coordinated rotation of 400+ secrets across ~20 repositories and multiple teams (~33 PRs), built a reusable Aurora password-rotation mechanism, and re-architected Nexus/Artifactory/Harbor credentials away from shared LDAP identities onto dedicated, Terraform-managed, scoped service accounts — cutting blast radius and reducing rotation to a `terraform apply`.
- **Drove least-privilege access** across the platform — replaced broad Vault policies with per-team scoped policies via a staged, multi-wave rollout, backed by a custom transitive secret scanner to catch usage hidden in third-party actions and reusable workflows.
- **Led a security audit of all GitHub Apps** across 4 GitHub organizations — built custom API tooling to extract permissions and activity data, removed unused apps, and downscoped overly broad installations.
- **Designed self-hosted runner resilience** — after an AWS spot-instance exhaustion incident, implemented cluster-autoscaler priority-expander spot→on-demand fallback, eliminating CI outages.
- **Owned org-wide Kubernetes upgrades and modernization** (GKE + EKS, dev/stage/prod) with zero downtime — took this on within months of joining and have run it across versions since, including graceful node-pool migrations, rollout of shared cluster operators (ECK/CNPG/Keycloak), and an ingress migration.
- **Hardened the software supply chain** — migrated artifact-registry authentication to short-lived identity tokens and added container image/manifest vulnerability scanning to CI early in my tenure.

**Developer productivity & force-multiplication**
- **Became the Renovate platform owner** for engineering — self-hosted Renovate for the monorepo, designed sensitive-dependency patterns, and prevented production outages from faulty transitive dependencies.
- **Built reusable CI frameworks** — a smoke-test system for automated Kustomize component upgrades, an AI Commit Guard GitHub Action (adopted in the monorepo), ChatOps automation for team workflow management, and an AI-powered deliverables-summary system that automatically analyses issue activity into validated, categorised output summaries.
- **Recovered the monorepo's preview-environment system** after breaking upstream changes — drove a major Helm-chart upgrade across ingress, auth, secrets, Helm values and the CI deploy workflow, and authored the upgrade runbook that de-risks future upgrades for the team.
- **Authored and shared reusable AI agent "skills"** (registry, Vault, cost-analysis, node-migration, dev-testing, and more) and agentic workflows adopted across the team; an active driver of the organization's AI-first tooling direction.

**Cost / FinOps**
- **FinOps DRI** for the developer platform — managed artifact-storage thresholds, ran usage-trajectory and cross-cloud data-transfer cost analyses, built per-PR CI cost reporting with a savings leaderboard, and turned findings into a tracked reduction backlog (including a Nexus→GAR caching strategy to retire an artificial vendor quota).

**Enablement, mentoring & hiring**
- **First point of contact for 10+ teams** on platform topics (access, secrets, registries, CI, networking) — e.g. onboarding product teams onto self-hosted CI runners, a secure vendor-image proxy/cache for the self-managed product team, registry quota and retention fixes for the Console team, cross-cluster Kubernetes access for the monorepo DevOps team, and new datastore-version support — turning recurring requests into self-service documentation and tooling.
- **Held rotating DRI (directly-responsible-individual) roles** across the platform — medic and monorepo-CI medic shifts biased toward root-cause fixes over one-off silences, plus team-newsletter rotations.
- **Mentoring engineers** on infrastructure best practices including async workflows, security, containerization, and Kubernetes operations.
- **Leading and participating in hiring interviews** for new domain colleagues, including reviewing take-home tests, conducting whiteboard sessions, and facilitating peer interviews.

### advastore SE - Platform Engineer
**April 2023 – May 2024** (1 year 2 months) · Remote

Designed and built the entire infrastructure platform for automated warehouses running MQTT-driven microservices on on-prem Kubernetes, from bare metal to production - fully Infrastructure as Code with zero manual steps.

**Key achievements:**
- **Authored a reusable Pulumi (Go) Kubernetes library** that abstracted manifest creation into typed, composable functions - consumed as a dependency by a separate Pulumi program encoding the full infrastructure topology.
- **Designed a declarative "composition" contract** to solve version skew across independently-deployed services and many warehouses: a composition file named the services (product layer), an environment file pinned their concrete versions per environment (dev, stage, prod-warehouse-1, -2, …), and the Pulumi library compiled it into Kubernetes manifests. CI rendered each candidate composition into an ephemeral feature namespace, ran the full e2e suite there, and only a passing composition got tagged — that tag *was* the release (GitOps/FluxCD). Shifted the quality gate left and eliminated version-incompatibility incidents in production.
- **Built one-click cluster bootstrapping** from bare metal: Ansible + Terraform provisioning Proxmox VMs, Rancher deploying HA Kubernetes clusters, WireGuard for multi-site networking - scalable to an arbitrary number of warehouses.
- Supported developers and software architects in creating architectural proof-of-concepts. Established company-wide standards, self-service tools, and policies.

**Technologies:** Pulumi (Go), Terraform, Ansible, Kubernetes, FluxCD, WireGuard, Proxmox, Rancher, .NET, MySQL, MongoDB, Azure, Grafana Stack, Elastic Stack.

### VOO Aviation Service GmbH - DevOps Architect
**January 2022 – April 2023** (1 year 4 months) · Hybrid (Graz), Austria

Designed and built a fully cloud-agnostic Kubernetes infrastructure on top of bare-metal hardware and cloud VMs. Owned the full stack: Netmaker/WireGuard for multi-cloud networking, Rancher Kubernetes Engine, Ansible provisioning, FluxCD for GitOps, SOPS for secrets, Stackgres (Postgres), MongoDB, Neo4J, OpenEBS storage, and Prometheus/Grafana observability. Designed and maintained the entire CI/CD system and pipelines (Gitlab) which also ran onprem. Created disaster recovery plans and regular drills on prod-like environments.

### Reactive Reality - Site Reliability Engineer
**January 2021 – December 2021** (1 year) · Hybrid (Graz), Austria

Designed and maintained GitOps CI/CD workflows on Azure Kubernetes. Mentored fellow engineers and ran workshops on containerization, Kubernetes, Helm, and operators. Worked remotely with a globally distributed team.

### pink robin gmbh (wastebox.biz) - DevOps Engineer
**November 2017 – January 2021** (3 years 3 months) · Graz, Austria

Architected cloud infrastructure on AWS. Containerized all microservice workloads and introduced Blue/Green deployment for zero-downtime production releases. Built fully automated CI/CD pipelines enabling one-click production deployment. Monitored production systems and increased reliability.

- **Made a build-time-coupled React app environment-agnostic** by serving runtime config from `/.well-known` endpoints (per-environment URLs and public env vars) — a small change in the app's JS to read its config at runtime, plus an ingress route, replaced fragile per-environment frontend rebuilds.

### BearingPoint - System Engineer
**October 2012 – October 2017** (5 years 1 month) · Graz, Austria

Started as a **Java programmer** (Java, Oracle, MSSQL, JSF) for 2 years. Transitioned to a project where AngularJS was the leading technology - introduced UI E2E tests using the Protractor framework. Then moved into DevOps: built a fully automated release pipeline using JobDSL for Jenkins and automated feature branch creation across interdependent repositories.

### Accenture - Software Engineer
**October 2009 – September 2012** (3 years) · Vienna, Austria · Frankfurt, Germany · Manila, Philippines

Junior programmer in the financial sector: COBOL, JCL, DB2, then **Java, GWT, PostgreSQL, Swing**. Offshore exchange program in the Philippines. Next project: public services sector with **Java, Spring, and SOAP web services** as **Technical Lead and Product Owner** of a subproject.

- **Built a high-throughput DB2→PostgreSQL data pipeline** for the migration engine of a major bank merger (Commerzbank/Dresdner): a Java 7 + JDBC job that streamed millions of error records out of IBM DB2, reshaped them into our data model, and loaded them into PostgreSQL. Hit the throughput target by combining JDBC data-streaming with a 2-byte→1-byte encoding reduction and SQL **window functions** for the required grouping — pulling ~14M datasets in ~10 minutes (target: 10M / 30 min). Ran through the merger cutover weekend.

---

## Technical Skills

| Domain | Technologies |
|---|---|
| **Languages** | Go, Java, TypeScript, Python, .NET, Shell |
| **Cloud** | GCP (GKE, IAM, VPC, GAR, etc), AWS (EKS, ECS, Aurora, OpenSearch, etc), Azure |
| **Kubernetes** | GKE, EKS, Rancher, bare-metal, autoscaling, node pools, Helm |
| **IaC** | Terraform, Pulumi (Go), Kustomize, Ansible |
| **GitOps** | ArgoCD, FluxCD |
| **CI/CD** | GitHub Actions (ARC self-hosted runners), Jenkins, Azure DevOps, Gitlab |
| **Security** | Teleport (zero-trust access), Vault, SOPS, WireGuard, Okta SSO, Yubikey (GPG, FIDO, etc) |
| **Observability** | Prometheus, Grafana, Alertmanager, Elastic Stack, OpenCost |
| **Databases** | PostgreSQL, MySQL, MongoDB, Neo4j, Redis, Oracle, DB2, MSSQL |
| **Registries** | Harbor, GAR, DockerHub |
| **Coding Agents** | GitHub Copilot (preferred model: Claude Opus 4.6) — highly proficient; actively tracks new model developments to maintain peak efficiency |

---

## Open Source

### [HomeRacker](https://github.com/kellerlabs/homeracker) - Creator & Maintainer
A fully modular 3D-printable rack-building system. Open-spec parametric design (OpenSCAD + Fusion 360) supporting 10"/19" server racks, shelves, and custom configurations. 375+ stars, 28 forks, active community with Discord, YouTube channel, and community contributions repo.

- Built **[scadm](https://github.com/kellerlabs/homeracker/tree/main/cmd/scadm)** - a zero-dependency Python package manager for OpenSCAD (`pip install scadm`)
- Designed automated release pipeline using Camunda's GitHub Actions, Conventional Commits, and SemVer
- Created extensible Renovate preset for OpenSCAD dependency management

---

## Education

**HTBLuVA Pinkafeld** - Ing., IT & Organisation (2004–2009)

---

## Languages

- German (Native)
- English (Full Professional)
- Japanese (Elementary)
