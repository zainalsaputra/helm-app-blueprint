# app-template — reusable Helm application chart

[![Lint and test chart](https://github.com/zainalsaputra/app-template/actions/workflows/lint-test.yaml/badge.svg)](https://github.com/zainalsaputra/app-template/actions/workflows/lint-test.yaml)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/zainalsaputra/app-template/badge)](https://securityscorecards.dev/viewer/?uri=github.com/zainalsaputra/app-template)
[![License](https://img.shields.io/github/license/zainalsaputra/app-template)](LICENSE)

A reusable, secure-by-default Helm chart for deploying containerized web applications on Kubernetes.

The chart starts simple, but exposes production controls without coupling applications to a specific framework, cloud, ingress controller, GitOps tool, or secret manager.

## Why this chart?

- Deploy an HTTP application with only an image and port.
- Secure pod and ServiceAccount defaults.
- Native support for probes, Ingress, HPA, PDB, persistence, migrations, sidecars, and NetworkPolicy.
- JSON Schema validation for user-facing values.
- No embedded database, registry password, hard-coded certificate issuer, or Argo CD annotation.
- Tested examples for minimal and production-oriented installations.

## Quick start

From a local clone:

```bash
helm install my-app ./charts/app-template \
  --set image.repository=ghcr.io/example/my-app \
  --set image.tag=1.0.0 \
  --set container.ports.http.containerPort=3000
```

From the published repository after the first release:

```bash
helm repo add app-template https://zainalsaputra.github.io/app-template
helm repo update
helm install my-app app-template/app-template
```

Or from OCI:

```bash
helm install my-app oci://ghcr.io/zainalsaputra/charts/app-template --version 0.1.2
```

## Common examples

```bash
# Minimal application
helm template demo ./charts/app-template -f examples/minimal-values.yaml

# Production controls
helm template demo ./charts/app-template -f examples/production-values.yaml

# Externally managed Secret
helm template demo ./charts/app-template -f examples/existing-secret-values.yaml

# Migration hook
helm template demo ./charts/app-template -f examples/migration-values.yaml
```

## Secret handling

For production, create secrets with an external controller or your platform tooling and reference them:

```yaml
secret:
  existingSecret: my-app-secrets
```

`secret.create` exists for local development and simple use cases, but its values are stored in Helm release history. The chart never creates registry credentials; reference an existing pull secret through `imagePullSecrets`.

## Supported scope

The current chart targets stateless and optionally persistent applications managed by a Kubernetes Deployment. StatefulSet, DaemonSet, and CronJob controllers are intentionally outside the v0.x scope so the values contract stays approachable and stable.

## Documentation

- [Chart values](charts/app-template/README.md)
- [Publishing guide](docs/PUBLISHING.md)
- [Contributing](CONTRIBUTING.md)
- [Security policy](SECURITY.md)

## Validation

```bash
helm lint --strict ./charts/app-template
helm template test ./charts/app-template
helm template test ./charts/app-template -f examples/production-values.yaml
helm unittest ./charts/app-template
```

CI also validates rendered manifests with kubeconform and installs the chart into a temporary Kind cluster through Helm chart-testing.

## Publishing status

The chart is published through GitHub Pages and GHCR. Artifact Hub registration remains a one-time maintainer step described in the [publishing guide](docs/PUBLISHING.md).

## License

Apache License 2.0.
