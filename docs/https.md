# Local HTTPS with Caddy

Caddy is a good fit for local HTTPS because it can manage local certificates for development.

## Basic idea

Instead of:

- `http://flux.test`

You can use:

- `https://flux.test`

## How it works

When Caddy manages TLS locally, it uses a local CA and issues certificates trusted by your machine once that CA is installed.

## First-time trust step

Run:

```bash
caddy trust
```

You may be prompted for admin privileges so Caddy can install its local root certificate.

## Then run Caddy normally

```bash
caddy run --config ./caddy/Caddyfile
```

## Verify

Open:

```text
https://flux.test
```

## Notes

- If the browser warns about trust, run `caddy trust` again.
- Some apps need extra config if they generate absolute callback URLs and assume `http`.
- Websocket-based dev servers usually work fine through Caddy.

## Optional explicit TLS example

Usually Caddy can infer this automatically, but an app file can also include explicit TLS behavior if needed.

```caddy
flux.test {
  reverse_proxy localhost:3000
}
```

For many local setups, that is enough.
