# Security policy

## Supported versions

Security fixes are provided for the latest minor release of the chart. Users should upgrade to the newest patch release before reporting an issue.

## Reporting a vulnerability

Do not open a public issue for a suspected vulnerability. Use GitHub's private vulnerability reporting feature under **Security > Advisories > Report a vulnerability**.

Include:

- Affected chart version.
- The rendered Kubernetes resources involved.
- Reproduction steps.
- Expected impact.
- Any suggested mitigation.

Maintainers should acknowledge a report within five business days and coordinate disclosure after a fix is available.

## Scope

This policy covers the Helm chart templates and release process. Vulnerabilities in an application image selected by a chart user must be reported to that image's publisher.

## Release provenance

Helm chart repository releases are signed with a dedicated release key. The public key is available at `keys/helm-app-blueprint.asc`, and signed packages can be verified with `helm verify` when the matching `.tgz.prov` file is present.
