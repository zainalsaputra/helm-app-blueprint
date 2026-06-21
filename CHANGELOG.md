# Changelog

All notable changes are documented here. This project follows Semantic Versioning for the chart API.

## [Unreleased]

## [0.1.2] - 2026-06-22

### Added

- Kubeconform validation for default and example manifests.
- Helm unit tests for secure defaults, image digests, and autoscaling behavior.
- OpenSSF Scorecard analysis and CODEOWNERS metadata.

### Security

- Pin GitHub Actions to immutable commit SHAs.

## [0.1.1] - 2026-06-21

### Fixed

- Set an explicit numeric non-root user and group for the Helm connection test so Kubernetes can validate the container security context.

## [0.1.0] - 2026-06-21

### Added

- Reusable Deployment-based application chart.
- Secure pod, container, and ServiceAccount defaults.
- ConfigMap and existing Secret integration with checksum rollouts.
- Service, Ingress, startup/readiness/liveness probes, HPA, and PDB.
- Scheduling, persistence, migration Job, NetworkPolicy, init containers, sidecars, and extra objects.
- JSON Schema validation, examples, Helm tests, CI, and release workflows.
