# Patrick Pötz

**Senior Software Engineer, Infrastructure**
Pöllau, Styria, Austria (Remote - EU)

📧 kellervater@gmail.com · 🔗 [linkedin.com/in/patrickpoetz](https://www.linkedin.com/in/patrickpoetz) · 💻 [github.com/kellervater](https://github.com/kellervater)

---

## Summary

Platform engineer with 16 years of experience, starting as a Java developer building financial systems and evolving into an infrastructure architect. I build software to make other engineers more productive - owning developer platforms, CI/CD infrastructure, Kubernetes clusters, and cross-team platform services at scale. I think like a programmer when solving infrastructure problems: I write reusable frameworks, design self-service abstractions, and ship end-to-end with minimal to no oversight. Over the past year I've become highly proficient with AI coding agents — maintaining a deliberate balance between staying current with the latest model developments and squeezing real day-to-day efficiency out of them (preferred model: Claude Opus 4.6). Highly efficient in async work (established since the 2020 Covid shift) and an evangelist for an async-first workstyle—prioritizing group chats over DMs and respecting each other's time ("let's hop on a quick chat" are absolute exceptions reserved for incidents).

---

## Experience

### Camunda - Senior Software Engineer, Infrastructure
**June 2024 – Present** · Remote

Owner of Camunda's developer platform serving 100+ engineers across 10+ product teams. Scope includes CI/CD infrastructure (GitHub Actions self-hosted runners on EKS, preview environments per Github Labels), Kubernetes clusters (GKE + EKS), container registries (Harbor), dependency management (Renovate), monitoring (Prometheus/Grafana), and cross-team platform services.

**Key achievements:**
- **DRI for the Zeebe Benchmark Platform Migration** - multi-quarter project migrating an entire team's benchmark infrastructure (GKE cluster, Prometheus/Grafana monitoring, Harbor registry, Teleport RBAC, AWS ECS workloads) from a team-owned environment to the centrally managed Infra platform. Delivered across 4 iterations with cross-functional coordination. Final ECS monitoring iteration: 6-day deadline, shipped in 4.
- **Built a zero-trust Kubernetes access platform** using Teleport - prototyped at hackathon, productionized and rolled out to 4 engineering teams. Designed team-scoped RBAC roles, Vault integration, and GitHub Actions bot access.
- **Designed self-hosted runner resilience** - after an AWS spot instance exhaustion incident, implemented cluster autoscaler priority expander for automatic spot-to-on-demand fallback, eliminating CI outages.
- **Owned org-wide Kubernetes upgrades** (GKE + EKS) across dev/stage/prod with zero downtime.
- **Led a security audit of all GitHub Apps** across 4 GitHub organizations - built custom API tooling to extract permissions and activity data, removed unused apps, downscoped overly broad installations.
- **Became the Renovate platform owner** for engineering - self-hosted Renovate for the monorepo, designed sensitive-dependency patterns, and prevented production outages from faulty transitive dependencies.
- **Built reusable CI frameworks**: smoke test system for automated Kustomize component upgrades, AI Commit Guard GitHub Action (adopted in monorepo), ChatOps automation for team workflow management.
- **Mentoring engineers** on infrastructure best practices including async workflows, security, containerization, and Kubernetes operations.
- **Leading and participating in hiring interviews** for new domain colleagues, including reviewing take-home tests, conducting whiteboard sessions, and facilitating peer interviews.

### advastore SE - Platform Engineer
**April 2023 – May 2024** (1 year 2 months) · Remote

Designed and built the entire infrastructure platform for automated warehouses running MQTT-driven microservices on on-prem Kubernetes, from bare metal to production - fully Infrastructure as Code with zero manual steps.

**Key achievements:**
- **Authored a reusable Pulumi (Go) Kubernetes library** that abstracted manifest creation into typed, composable functions - consumed as a dependency by a separate Pulumi program encoding the full infrastructure topology.
- **Invented a "composition file" system** for version-safe deployments: CI automatically generated a manifest of compatible microservice versions, validated it through integration tests, and tagged it for GitOps reconciliation (FluxCD). Eliminated version incompatibility incidents in production.
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

### BearingPoint - System Engineer
**October 2012 – October 2017** (5 years 1 month) · Graz, Austria

Started as a **Java programmer** (Java, Oracle, MSSQL, JSF) for 2 years. Transitioned to a project where AngularJS was the leading technology - introduced UI E2E tests using the Protractor framework. Then moved into DevOps: built a fully automated release pipeline using JobDSL for Jenkins and automated feature branch creation across interdependent repositories.

### Accenture - Software Engineer
**October 2009 – September 2012** (3 years) · Vienna, Austria · Frankfurt, Germany · Manila, Philippines

Junior programmer in the financial sector: COBOL, JCL, DB2, then **Java, GWT, PostgreSQL, Swing**. Offshore exchange program in the Philippines. Next project: public services sector with **Java, Spring, and SOAP web services** as **Technical Lead and Product Owner** of a subproject.

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
| **Databases** | PostgreSQL, MySQL, MongoDB, Neo4j, Redis, Oracle, MSSQL |
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
