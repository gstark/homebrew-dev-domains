# Adding apps

## 1. Pick a hostname

Use a short hostname that will become `<name>.127.0.0.1.nip.io`, for example:

- `billing.127.0.0.1.nip.io`
- `search.127.0.0.1.nip.io`
- `admin.127.0.0.1.nip.io`

## 2. Find the dev server port

Examples:

- Vite: often `5173`
- Next.js: often `3000`
- Rails: often `3000`
- Phoenix: often `4000`

## 3. Create an app config file

Fastest option:

```bash
dev-domains new-app --name billing --port 4321
```

If running from source before installation:

```bash
./bin/dev-domains new-app --name billing --port 4321
```

That creates:

```text
caddy/apps/billing.caddy
```

Equivalent manual file:

```caddy
billing.127.0.0.1.nip.io {
  reverse_proxy localhost:4321
}
```

## 4. Reload Caddy

```bash
dev-domains reload
```

## 5. Optional helper commands

List apps:

```bash
dev-domains list-apps
```

Edit an app port:

```bash
dev-domains edit-app --name billing --port 5000
```

Open an app:

```bash
dev-domains open --name billing
```

Remove an app:

```bash
dev-domains remove-app --name billing
```

Check overall status:

```bash
dev-domains status
```

## 6. Start the app

Make sure your app is actually listening on the port you configured.

## 7. Open it

Visit:

```text
http://billing.127.0.0.1.nip.io
```

## Common framework notes

### Vite

You may need to allow custom hosts in your Vite config.

### Next.js

If needed, make sure the dev server is bound in a way Caddy can reach.

### Webpack dev server

You may need host allowlisting depending on your config.
