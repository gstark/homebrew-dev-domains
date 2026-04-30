# macOS setup

## Install dependencies

```bash
brew install caddy
```

## Start Caddy

```bash
brew services start caddy
```

Or run the helper:

```bash
dev-domains setup
```

Or run Caddy manually:

```bash
make run-caddy
```

## Verify DNS

```bash
dig flux.127.0.0.1.nip.io
```

Expected result includes:

```text
127.0.0.1
```

## Verify proxying

Start the app on port `9000`, then open:

```text
http://flux.127.0.0.1.nip.io
```

## Optional: enable local HTTPS trust

```bash
caddy trust
```

Then you can use `https://flux.127.0.0.1.nip.io` style URLs.

## Reloading Caddy after config changes

```bash
make reload-caddy
```
