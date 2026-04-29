# dev-domains

Friendly local domains for multiple dev servers using **Caddy** + **dnsmasq** on macOS.

`dev-domains` gives your local apps stable URLs like `flux.test` and `dashboard.test`, while each app continues running on its normal dev port.

Examples:

- `http://flux.test` -> `localhost:3000`
- `http://dashboard.test` -> `localhost:3001`
- `http://aipro.test` -> `localhost:5173`
- `http://observe.test` -> `localhost:8080`

App configs live in `caddy/apps/*.caddy`, so each project can have its own small file.

## Why this exists

When you run several local apps at once, remembering ports gets annoying. `dev-domains` gives each app a stable hostname while keeping the app itself on its normal dev port.

## Stack

- **dnsmasq**: resolves `*.test` to `127.0.0.1`
- **Caddy**: reverse proxies by hostname to the right local port
- **macOS resolver**: tells macOS to ask local dnsmasq for `.test`

## Why `.test` and not `.local`

Use `.test`.

`.local` is commonly used by mDNS / Bonjour and can cause conflicts. `.test` is the safer local-dev choice.

## Quick start

### From source

1. Install dependencies:

   ```bash
   brew install caddy dnsmasq
   ```

2. Run the setup script:

   ```bash
   ./scripts/setup-macos.sh
   ```

   Or use the CLI bootstrap command:

   ```bash
   ./bin/dev-domains install-and-setup
   ```

3. Start your dev servers.

4. Open:

   - `http://flux.test`
   - `http://dashboard.test`
   - `http://aipro.test`
   - `http://observe.test`

### Via Homebrew

1. Install `dev-domains`:

   ```bash
   brew tap gstark/dev-domains
   brew install dev-domains
   ```

   Homebrew will install `caddy` and `dnsmasq` automatically.

2. Run setup:

   ```bash
   dev-domains setup
   ```

   Or, if you want one command for dependency install + setup outside normal Homebrew usage:

   ```bash
   dev-domains install-and-setup
   ```

   This still needs sudo because it creates `/etc/resolver/test`.

3. Start your dev servers.

4. Open:

   - `http://flux.test`
   - `http://dashboard.test`
   - `http://aipro.test`
   - `http://observe.test`

## Repo layout

- `Makefile` — convenience commands
- `caddy/Caddyfile` — root Caddy config that imports app files
- `caddy/apps/*.caddy` — one file per app
- `dnsmasq/dev.conf` — dnsmasq wildcard rule for `.test`
- `scripts/setup-macos.sh` — bootstraps resolver and dnsmasq config on macOS
- `scripts/new-app.sh` — creates a new app config file
- `docs/macos-setup.md` — step-by-step setup
- `docs/adding-apps.md` — how to add more projects

## Adding a new app

Use the CLI:

```bash
dev-domains new-app --name newapp --port 4321
```

If running from source before installation:

```bash
./bin/dev-domains new-app --name newapp --port 4321
```

That creates:

- `caddy/apps/newapp.caddy`

Then reload Caddy:

```bash
dev-domains reload
```

No `/etc/hosts` edits are needed.

## Notes

- If a dev server rejects custom hostnames, configure that app to allow them.
- Some frameworks also need `--host 0.0.0.0` or similar.
- HTTPS is supported too; see the HTTPS doc.
- `brew install dev-domains` can install dependencies automatically, but it should not silently perform privileged system setup during formula installation.

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
