# Local HTTPS with Caddy

Caddy is a good fit for local HTTPS because it can manage local certificates for development.

## Basic idea

Instead of:

- `http://myapp.lvh.me`

You can use:

- `https://myapp.lvh.me`

## First-time trust step

Run:

```bash
caddy trust
```

You may be prompted for admin privileges so Caddy can install its local root certificate.

## Then run Caddy normally

```bash
caddy run --config ~/.config/dev-domains/Caddyfile
```

## Verify

Open:

```text
https://myapp.lvh.me
```

## Notes

- If the browser warns about trust, run `caddy trust` again.
- Some apps need extra config if they generate absolute callback URLs and assume `http`.
- Websocket-based dev servers usually work fine through Caddy.

## Example

```caddy
myapp.lvh.me {
  reverse_proxy localhost:3000
}
```
