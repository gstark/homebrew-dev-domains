# Repo structure

## Top level

- `README.md` — overview and quick start
- `Makefile` — convenience commands
- `scripts/` — helper scripts
- `caddy/` — Caddy config
- `docs/` — setup and troubleshooting docs

## Caddy layout

- `caddy/Caddyfile` — root config that imports app configs
- `caddy/apps/*.caddy` — one file per local app

This makes it easy to add or remove a project without editing one large config file.

## Example

`caddy/apps/flux.caddy`

```caddy
flux.127.0.0.1.nip.io {
  reverse_proxy localhost:9000
}
```
