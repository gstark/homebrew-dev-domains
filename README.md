# dev-domains

Friendly local domains for multiple dev servers using **Caddy** + **nip.io**.

`dev-domains` gives your local apps stable URLs like `flux.127.0.0.1.nip.io` and `dashboard.127.0.0.1.nip.io`, while each app continues running on its normal dev port.

Examples:

- `http://flux.127.0.0.1.nip.io` -> `localhost:9000`
- `http://dashboard.127.0.0.1.nip.io` -> `localhost:3001`
- `http://aipro.127.0.0.1.nip.io` -> `localhost:5173`
- `http://observe.127.0.0.1.nip.io` -> `localhost:8080`

App configs live in `caddy/apps/*.caddy`, so each project can have its own small file.

## Why this exists

When you run several local apps at once, remembering ports gets annoying. `dev-domains` gives each app a stable hostname while keeping the app itself on its normal dev port.

## Stack

- **nip.io**: resolves `*.127.0.0.1.nip.io` to `127.0.0.1`
- **Caddy**: reverse proxies by hostname to the right local port

No `dnsmasq`, `/etc/resolver`, or `/etc/hosts` edits are needed.

## Quick start

### From source

1. Install dependencies:

   ```bash
   brew install caddy
   ```

2. Start Caddy:

   ```bash
   ./scripts/setup-macos.sh
   ```

   Or use the CLI bootstrap command:

   ```bash
   ./bin/dev-domains install-and-setup
   ```

3. Start your dev servers.

4. Open:

   - `http://flux.127.0.0.1.nip.io`
   - `http://dashboard.127.0.0.1.nip.io`
   - `http://aipro.127.0.0.1.nip.io`
   - `http://observe.127.0.0.1.nip.io`

### Via Homebrew

1. Install `dev-domains`:

   ```bash
   brew tap gstark/dev-domains
   brew install dev-domains
   ```

2. Run setup:

   ```bash
   dev-domains setup
   ```

   Or, if you want one command for dependency install + setup outside normal Homebrew usage:

   ```bash
   dev-domains install-and-setup
   ```

3. Start your dev servers.

4. Open:

   - `http://flux.127.0.0.1.nip.io`
   - `http://dashboard.127.0.0.1.nip.io`
   - `http://aipro.127.0.0.1.nip.io`
   - `http://observe.127.0.0.1.nip.io`

## Repo layout

- `Makefile` — convenience commands
- `caddy/Caddyfile` — root Caddy config that imports app files
- `caddy/apps/*.caddy` — one file per app
- `scripts/setup-macos.sh` — starts Caddy for local routing
- `scripts/new-app.sh` — creates a new app config file
- `docs/macos-setup.md` — step-by-step setup
- `docs/adding-apps.md` — how to add more projects

## Managing apps

Create an app:

```bash
dev-domains new-app --name newapp --port 4321
```

If running from source before installation:

```bash
./bin/dev-domains new-app --name newapp --port 4321
```

That creates:

- `caddy/apps/newapp.caddy`

List apps:

```bash
dev-domains list-apps
```

Edit an app port:

```bash
dev-domains edit-app --name newapp --port 5000
```

Reload Caddy:

```bash
dev-domains reload
```

Open an app:

```bash
dev-domains open --name newapp
```

Remove an app:

```bash
dev-domains remove-app --name newapp
```

Check overall status:

```bash
dev-domains status
```

## Notes

- If a dev server rejects custom hostnames, configure that app to allow them.
- Some frameworks also need `--host 0.0.0.0` or similar.
- `DEV_DOMAINS_IP` can be set if you want to generate `nip.io` hostnames for a different local IP.
- HTTPS is supported too; see the HTTPS doc.
- Use `dev-domains doctor` to verify your local setup.

## Docs

- [macOS setup](./docs/macos-setup.md)
- [Adding apps](./docs/adding-apps.md)
- [Local HTTPS](./docs/https.md)
- [Homebrew install](./docs/homebrew.md)
- [Repo structure](./docs/repo-structure.md)
- [Troubleshooting](./docs/troubleshooting.md)
- [Contributing](./CONTRIBUTING.md)

## License

[MIT](./LICENSE)
