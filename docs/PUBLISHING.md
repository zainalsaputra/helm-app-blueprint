# Publishing

## 1. Verify repository identity

Repository metadata is configured for `zainalsaputra/helm-app-blueprint`. Before moving the project to another GitHub owner, update:

- `charts/app-blueprint/Chart.yaml`
- `cr.yaml`
- `README.md`

Confirm that the `Chart.yaml` icon URL points to the final GitHub owner.

## 2. Protect the repository

- Require pull requests for `main`.
- Require the lint-and-test workflow.
- Enable Dependabot and secret scanning.
- Enable private vulnerability reporting.
- Restrict workflow token permissions to the minimum required by each job.

## 3. Publish a GitHub Pages Helm repository

Create an empty `gh-pages` branch and configure GitHub Pages to serve it. The `release-pages.yaml` workflow packages chart versions that have not been released and updates `index.yaml`.

Install after publishing:

```bash
helm repo add helm-app-blueprint https://zainalsaputra.github.io/helm-app-blueprint
helm repo update
helm install my-app helm-app-blueprint/app-blueprint
```

## 4. Publish OCI

Create and push a tag matching the chart:

```bash
git tag app-blueprint-0.2.0
git push origin app-blueprint-0.2.0
```

The OCI workflow verifies that the Git tag matches `Chart.yaml`, packages the chart, and pushes it to `ghcr.io/<owner>/charts/app-blueprint`.

For first-time publishing or recovery, the same workflow can be started manually with the chart version as its input.

## 5. Artifact Hub

Register the GitHub Pages URL as a Helm repository. Artifact Hub returns a repository ID. Copy `artifacthub-repo.yml.example` to the root of the publishing branch as `artifacthub-repo.yml`, then replace the repository ID and owner details.

Verified Publisher proves control over the repository. Official status is generally not applicable because this generic chart does not own the applications users deploy.

## 6. Release checklist

- Update chart `version` using Semantic Versioning.
- Update `appVersion` only when the default demonstration image changes.
- Update `CHANGELOG.md` and `artifacthub.io/changes`.
- Run lint, all render scenarios, package validation, and a Kind install.
- Confirm no secret value exists in source or generated examples.
- Create the matching Git tag after the main branch release is green.
