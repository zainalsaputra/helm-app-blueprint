# App Blueprint chart

Deploy a containerized web application using a Kubernetes Deployment.

## Requirements

- Helm 3.12 or newer
- Kubernetes 1.27 or newer

## Install

```bash
helm install my-app ./charts/app-blueprint \
  --set image.repository=ghcr.io/example/my-app \
  --set image.tag=1.0.0
```

## Key values

| Value | Default | Description |
|---|---:|---|
| `replicaCount` | `1` | Replicas when HPA is disabled |
| `image.repository` | `nginxinc/nginx-unprivileged` | Application image repository |
| `image.tag` | `1.27-alpine` | Application image tag |
| `image.digest` | `""` | Optional immutable SHA-256 digest |
| `container.ports` | HTTP 8080 | Named application ports |
| `configMap.create` | `false` | Create non-sensitive environment data |
| `secret.existingSecret` | `""` | Existing application Secret |
| `service.enabled` | `true` | Create a Service |
| `ingress.enabled` | `false` | Create an Ingress |
| `probes.*` | readiness/liveness enabled | Native Kubernetes probes |
| `autoscaling.enabled` | `false` | Create an autoscaling/v2 HPA |
| `podDisruptionBudget.enabled` | `false` | Create a PDB |
| `persistence.enabled` | `false` | Mount a new or existing PVC |
| `migration.enabled` | `false` | Run a migration Job |
| `networkPolicy.enabled` | `false` | Create a NetworkPolicy |
| `initContainers` | `[]` | Native init container definitions |
| `sidecars` | `[]` | Native sidecar definitions |
| `extraObjects` | `[]` | Additional templated Kubernetes objects |

Every value is documented in `values.yaml` and validated by `values.schema.json`.

## ConfigMap and Secret

```yaml
configMap:
  create: true
  data:
    LOG_LEVEL: info

secret:
  existingSecret: my-app-secrets
```

The generated ConfigMap and Secret receive checksum annotations on the pod template, causing a rollout when their contents change.

## Custom probes

Probe bodies use native Kubernetes syntax:

```yaml
probes:
  readiness:
    enabled: true
    httpGet:
      path: /health/ready
      port: http
  liveness:
    enabled: true
    tcpSocket:
      port: http
```

## Migration

```yaml
migration:
  enabled: true
  command: ["npm"]
  args: ["run", "migration:run"]
```

By default, migration runs as a `pre-install,pre-upgrade` Helm hook. Disable `migration.hook.enabled` when a GitOps controller should manage it as a regular Job.

## Persistence

```yaml
persistence:
  enabled: true
  mountPath: /app/data
  size: 5Gi
```

Set `persistence.existingClaim` to reuse a PVC. The chart does not create StorageClasses.

## Upgrade safety

Chart versions follow Semantic Versioning. Breaking values changes require a new major chart version. Always inspect changes before upgrade:

```bash
helm diff upgrade my-app helm-app-blueprint/app-blueprint -f my-values.yaml
```
