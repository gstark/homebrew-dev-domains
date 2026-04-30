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
dig myapp.lvh.me
```

Expected result includes:

```text
127.0.0.1
```

## Verify proxying

Create an app with `dev-domains new-app --name myapp --port 3000`, start it, then open:

```text
http://myapp.lvh.me
```

## Optional: enable local HTTPS trust

```bash
caddy trust
```

Then you can use `https://myapp.lvh.me` style URLs.

## Reloading Caddy after config changes

```bash
make reload-caddy
```
