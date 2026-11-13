# Patrick Pötz

**Senior Software Engineer, Infrastructure**
Pöllau, Styria, Austria (Remote - EU)

📧 kellervater@gmail.com · 🔗 [linkedin.com/in/patrickpoetz](https://www.linkedin.com/in/patrickpoetz) · 💻 [github.com/kellervater](https://github.com/kellervater)

---

## Summary

Platform engineer with 16+ years of experience, starting as a Java developer in the financial and public-services sectors and moving into infrastructure architecture and developer-platform ownership. I build software that makes other engineers more productive, and I increasingly own the technical direction behind it: developer platforms, CI/CD, Kubernetes, and cross-team platform services for 100+ engineers across 10+ teams. Most of my work has leverage well beyond my own tickets. I write reusable frameworks, design self-service abstractions, lead cross-team migrations and security incidents, and set up practices (ADRs, roadmaps, scoped-access models) that other teams adopt. I think like a programmer when solving infrastructure problems and ship end-to-end with minimal oversight. Over the past year I've spent a lot of time on AI coding agents, writing reusable agent skills and agentic workflows for the team while keeping up with new models and getting real day-to-day efficiency out of them by continuously building out my personal OS. I work best async and push for an async-first workstyle: group chats over DMs, and respect for each other's time, where "let's hop on a quick chat" is reserved for incidents and for building connective tissue.

---

## Experience

### Camunda - Senior Software Engineer, Infrastructure
**June 2024 - Present** · Remote

Run Camunda's developer platform for 100+ engineers across 10+ product teams together with the Infra team: self-hosted GitHub Actions runners on GKE and EKS, preview environments, Kubernetes, container registries (Harbor), dependency automation (Renovate), observability (Prometheus/Grafana) and secrets management (Vault). My focus is secure software delivery. Scope grew from onboarding single teams, to org-wide platform operations, to owning multi-quarter cross-team programs and leading the Infra side of security incidents.

**🔐 Supply-chain and platform security**
- **Keyless CI identities, org-wide:** moved CI secrets access for 100+ repositories from one broad credential to team-scoped, least-privilege policies in staged waves, backed by a transitive usage scanner that finds secrets consumed inside third-party actions and reusable workflows. Now leading the move to keyless OIDC authentication (50+ repositories in the first weeks, driven by inventory and transform tooling I built), and published [`vault-wrapped-secrets`](https://github.com/camunda/infra-global-github-actions/tree/main/vault-wrapped-secrets) so jobs, including AI agent jobs, receive secrets without holding credentials.
- **Incident lead on the Infra side during software supply-chain attacks:** built an audit-log-driven exposure analyzer and a prioritised rotation playbook, coordinated owners across teams, and rotated every critical credential within a week. Replaced shared registry credentials with scoped, Terraform-managed and ephemeral ones, so rotation is now a `terraform apply`.
- **Turned incidents into structural hardening:** SHA-pinned third-party actions with enforced workflow linting, digest-pinned container images, and secrets-manager backups moved outside their own trust domain (dual-key encryption, freshness alerting, tested restore drills). I reworked the backup design after a security review challenged its premise.
- **GitHub App governance:** ran the first audit of GitHub App installations across several organisations with an owner per app, and am now designing a tiered GitHub App standard that turns most access requests into a single reviewed PR.
- Introduced tokenless package publishing (OIDC Trusted Publishing), moved artifact-registry auth to identity tokens and added infrastructure-as-code vulnerability scanning to CI early in my tenure.

**⚡ CI/CD and developer productivity**
- **Started and run the Reduce Developer Toil program:** shipped PR-lifetime leases for shared dev infrastructure (decision record, CLI, enforcement in apply targets and CI, a lease board), a component-test framework on AWS and GCP dev clusters that gates Renovate automerge for a dozen core platform components, a skill that generates component tests from real usage patterns, and an agent that retires upstream workarounds once fixes land (16 repositories). Agent access to dev infrastructure for AI-driven maintenance is the stage in progress.
- **Incident commander for CI platform incidents**, following every mitigation with a structural fix: for example pruning non-shipped dependency scopes cut a license-scan job from about 30 to under 10 minutes on main and all stable branches, and root-causing intermittent CI failures to a DNS negative-caching race came with a validating test suite.
- **Self-hosted runner resilience:** spot-to-on-demand fallback with a cluster-autoscaler priority expander, routine component-tested runner-controller upgrades and GitOps self-healing for CI apps.
- **Preview environments and ingress:** restored the monorepo's preview environments through a major Helm-chart upgrade with a runbook, delivered my chapter of the team's ingress-nginx to Traefik and Gateway API migration across the CI clusters, and shipped a Helm v4 rendering upgrade with no stage or prod outages.
- **Reusable CI building blocks:** automated releases for 25 infrastructure repositories (two reusable actions plus conventional-commit enforcement), preview-environment feedback actions in 7 product repositories, self-service namespace-scoped Kubernetes access for product teams and their CI bots, and shared, smoke-tested Kubernetes operators so teams test operator-managed deployments without their own infrastructure.
- **CI cost model:** built a cost-per-PR model for the self-hosted CI fleet, cross-validated against the CI provider's API, and turned it into a ranked savings plan with owned follow-ups and a reusable analysis skill.

**🧭 Direction and leverage**
- **Led a multi-quarter, cross-team platform migration:** moved a product team's performance-benchmark environment onto dedicated, isolated clusters (network plan, Terraform, GitOps, workload identity, private registry networking, alerting) and handed it back as self-service. The owning team has since contributed 40+ changes directly.
- **Introduced decision records** for our infrastructure codebase; they now back node-pool migrations, shared operators, dev leases, backup design and GitOps self-healing. Authored the roadmaps and epics the team executes on and contributed to the team's multi-year technical vision.
- **AI as a team force multiplier:** agent skills that encode operational runbooks (registry setup, secrets onboarding, cost analysis, disruption-free node-pool migration, component-test creation), agent-authored PRs dispatched straight from request threads, and generated stand-ups and a newsletter skill that became the team's handover process.
- **Leverage through others:** delegated cost initiatives, the FinOps and newsletter roles with written handovers and reusable skills, and reviewed them to closure. Started customer discovery with engineers across R&D to steer what the CI/CD platform solves next.
- **First point of contact for 10+ teams** on platform topics, with 300+ support requests answered, turning recurring ones into self-service docs, skills and tooling. Rotating DRI for medic, maintenance, FinOps and security.
- **Mentoring and hiring:** onboarding buddy and mentor for new engineers, whiteboard and peer interviews (including as lead), and a grading heuristic for AI-generated take-home submissions.

### advastore SE - Platform Engineer
**April 2023 - May 2024** (1 year 2 months) · Remote

Designed and built the entire infrastructure platform for automated warehouses running MQTT-driven microservices on on-prem Kubernetes, from bare metal (on top of Proxmox) to production, fully Infrastructure as Code (Ansible, Terraform with an Azure backend, RKE2, and Pulumi in Go) with zero manual steps.

**Key achievements:**
- **Authored a reusable Pulumi (Go) Kubernetes library** that abstracted manifest creation into typed, composable functions, consumed as a dependency by a separate Pulumi program encoding the full infrastructure topology.
- **Designed a declarative "composition" contract** to solve version skew across independently-deployed services and many warehouses: a composition file named the services (product layer), an environment file pinned their concrete versions per environment (dev, stage, prod-warehouse-1, -2, …), and the Pulumi library (written in Go) compiled it into Kubernetes manifests. CI rendered each candidate composition into an ephemeral feature namespace, ran the full e2e suite there, and only a passing composition got tagged, and that tag *was* the release (GitOps/FluxCD). This shifted the quality gate left and eliminated version-incompatibility incidents in production.
- **Built one-click cluster bootstrapping** from bare metal: Ansible + Terraform provisioning Proxmox VMs, Rancher deploying HA Kubernetes clusters, WireGuard for multi-site networking, scalable to an arbitrary number of warehouses.
- Supported developers and software architects in creating architectural proof-of-concepts. Established company-wide standards, self-service tools, and policies.

**Technologies:** Pulumi (Go), Terraform, Ansible, Kubernetes, FluxCD, WireGuard, Proxmox, Rancher, .NET, MySQL, MongoDB, Azure, Grafana Stack, Elastic Stack.

### VOO Aviation Service GmbH - DevOps Architect
**January 2022 - April 2023** (1 year 4 months) · Hybrid (Graz), Austria

Designed and built a fully cloud-agnostic Kubernetes infrastructure on top of bare-metal hardware and cloud VMs. Owned the full stack: Netmaker/WireGuard for multi-cloud networking, Rancher Kubernetes Engine, Ansible provisioning, FluxCD for GitOps, SOPS for secrets, Stackgres (Postgres), MongoDB, Neo4J, OpenEBS storage, and Prometheus/Grafana observability. Designed and maintained the entire CI/CD system and pipelines (Gitlab) which also ran on-prem. Created disaster recovery plans and regular drills on prod-like environments.

### Reactive Reality - Site Reliability Engineer
**January 2021 - December 2021** (1 year) · Hybrid (Graz), Austria

Designed and maintained GitOps CI/CD workflows on Azure Kubernetes. Mentored fellow engineers and ran workshops on containerization, Kubernetes, Helm, and operators. Worked remotely with a globally distributed team.

### pink robin gmbh (wastebox.biz) - DevOps Engineer
**November 2017 - January 2021** (3 years 3 months) · Graz, Austria

Architected cloud infrastructure on AWS. Containerized all microservice workloads and introduced Blue/Green deployment for zero-downtime production releases. Built fully automated CI/CD pipelines enabling one-click production deployment. Monitored production systems and increased reliability.

- **Made a build-time-coupled React app environment-agnostic** by serving runtime config from `/.well-known` endpoints (per-environment URLs and public env vars). A small change in the app's JS to read its config at runtime, plus an ingress route, replaced fragile per-environment frontend rebuilds.

### BearingPoint - System Engineer
**October 2012 - October 2017** (5 years 1 month) · Graz, Austria

Started as a **Java programmer** (Java, Oracle, MSSQL, JSF) for 2 years. Transitioned to a project where AngularJS was the leading technology, where I introduced UI E2E tests using the Protractor framework. Then moved into DevOps: built a fully automated release pipeline using JobDSL for Jenkins and automated feature branch creation across interdependent repositories.

### Accenture - Software Engineer
**October 2009 - September 2012** (3 years) · Vienna, Austria · Frankfurt, Germany · Manila, Philippines

Junior programmer in the financial sector: COBOL, JCL, DB2, then **Java, GWT, PostgreSQL, Swing**. Offshore exchange program in the Philippines. Next project: public services sector with **Java, Spring, and SOAP web services** as **Technical Lead and Product Owner** of a subproject.

- **Built a high-throughput DB2→PostgreSQL data pipeline** for the migration engine of a major bank merger (Commerzbank/Dresdner): a Java 7 + JDBC job that streamed millions of error records out of IBM DB2, reshaped them into our data model, and loaded them into PostgreSQL. Hit the throughput target by combining JDBC data-streaming with a 2-byte→1-byte encoding reduction and SQL **window functions** for the required grouping, pulling ~14M datasets in ~10 minutes (target: 10M / 30 min). Ran through the merger cutover weekend.

---

## Technical Skills

| Domain | Technologies |
|---|---|
| **Languages** | Go, Java, TypeScript, Python, .NET, Shell |
| **Cloud** | GCP (GKE, IAM, VPC, GAR, etc), AWS (EKS, ECS, Aurora, OpenSearch, etc), Azure |
| **Kubernetes** | GKE, EKS, Rancher, bare-metal, autoscaling, node pools, Helm |
| **Virtualization** | Proxmox |
| **IaC** | Terraform, Pulumi (Go), Kustomize, Ansible |
| **GitOps** | ArgoCD, FluxCD |
| **CI/CD** | GitHub Actions (ARC self-hosted runners), Jenkins, Azure DevOps, Gitlab |
| **Security** | Teleport (zero-trust access), Vault, SOPS, WireGuard, Okta SSO, Yubikey (GPG, FIDO, etc) |
| **Observability** | Prometheus, Grafana, Alertmanager, Elastic Stack, OpenCost |
| **Databases** | PostgreSQL, MySQL, MongoDB, Neo4j, Redis, Oracle, DB2, MSSQL |
| **Registries** | Harbor, GAR, DockerHub |
| **Coding Agents** | Claude, GitHub Copilot, Gemini; highly proficient and actively tracking new model developments to stay efficient |

---

## Open Source

### [HomeRacker](https://github.com/kellerlabs/homeracker) - Creator & Maintainer
A fully modular 3D-printable rack-building system. Open-spec parametric design (OpenSCAD + Fusion 360) supporting 10"/19" server racks, shelves, and custom configurations. 375+ stars, 28 forks, active community with Discord, YouTube channel, and community contributions repo.

- Built **[scadm](https://github.com/kellerlabs/homeracker/tree/main/cmd/scadm)**, a zero-dependency Python package manager for OpenSCAD (`pip install scadm`)
- Designed automated release pipeline using Camunda's GitHub Actions, Conventional Commits, and SemVer
- Created extensible Renovate preset for OpenSCAD dependency management

---

## Education

**HTBLuVA Pinkafeld** - Ing., IT & Organisation (2004-2009)

---

## Languages

- German (Native)
- English (Full Professional)
- Japanese (Elementary)
