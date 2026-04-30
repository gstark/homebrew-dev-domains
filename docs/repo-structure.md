# Repo structure

## Top level

- `README.md` — overview and quick start
- `Makefile` — convenience commands
- `scripts/` — helper scripts
- `caddy/` — Caddy config
- `docs/` — setup and troubleshooting docs

## Caddy layout

- `~/.config/dev-domains/Caddyfile` — active root config that imports app configs
- `~/.config/dev-domains/apps/*.caddy` — one file per local app

This makes it easy to add or remove a project without editing one large config file.

The repo only ships the root Caddyfile template. App configs are user-created under `~/.config/dev-domains/apps/`.

## Example

`~/.config/dev-domains/apps/myapp.caddy`

```caddy
myapp.lvh.me {
  reverse_proxy localhost:3000
}
```
