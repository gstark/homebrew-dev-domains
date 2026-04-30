# Local HTTPS with Caddy

Caddy is a good fit for local HTTPS because it can manage local certificates for development.

## Basic idea

Instead of:

- `http://flux.127.0.0.1.nip.io`

You can use:

- `https://flux.127.0.0.1.nip.io`

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
https://flux.127.0.0.1.nip.io
```

## Notes

- If the browser warns about trust, run `caddy trust` again.
- Some apps need extra config if they generate absolute callback URLs and assume `http`.
- Websocket-based dev servers usually work fine through Caddy.

## Example

```caddy
flux.127.0.0.1.nip.io {
  reverse_proxy localhost:9000
}
```
