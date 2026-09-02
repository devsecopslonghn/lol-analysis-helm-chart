# Riot API collector

The collector is disabled by default. The Riot API key never belongs in Git,
the frontend image, or Helm values. Create one namespace-scoped Secret first:

```bash
kubectl -n lol-analysis create secret generic riot-api-credentials \
  --from-literal=RIOT_API_KEY='REDACTED_RIOT_KEY' \
  --from-literal=RIOT_COLLECT_TOKEN='REDACTED_INTERNAL_TOKEN' \
  --dry-run=client -o yaml | kubectl apply -f -
```

Then enable the existing secret in the environment values:

```yaml
riot:
  enabled: true
  existingSecret: riot-api-credentials
```

Do not put either value in this repository. `RIOT_COLLECT_TOKEN` is an
application-level guard for the internal collector endpoint; it is separate
from the Riot key. The browser sends the collector token in
`X-Collector-Token`, while the backend sends `X-Riot-Token` to Riot.

The API stores normalized match history below the existing report PVC at
`/var/lib/rofl-analysis/riot`. The single-replica MVP uses atomic JSON writes;
move this boundary to a database before enabling multiple writers/replicas.

Validate without changing the cluster:

```bash
helm lint .
helm template lol-analysis . --namespace lol-analysis \
  | kubectl apply --dry-run=server -f -
```
