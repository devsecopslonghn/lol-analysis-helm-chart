# LoL Analysis Helm Chart

Deploys the ROFL analysis backend, dashboard frontend and report PVC. The
backend owns JSON report generation; the frontend only renders backend data.

```bash
helm lint .
helm template lol-analysis . --namespace lol-analysis
```

The intended host is `lol-analysis.apps.drgdevlab.com`, but Ingress is disabled
by default until an authentication proxy is configured. Use port-forward for
the private MVP or provide an environment values file that enables Ingress
after auth is in place.

The report PVC contains user-created analysis data. Back it up before changing
storage or deleting the release. Image tags should be replaced with immutable
CI tags before a shared-environment sync.
