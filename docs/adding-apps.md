# Adding apps

## 1. Pick a hostname

Use a short hostname under `.test`, for example:

- `billing.test`
- `search.test`
- `admin.test`

## 2. Find the dev server port

Examples:

- Vite: often `5173`
- Next.js: often `3000`
- Rails: often `3000`
- Phoenix: often `4000`

## 3. Create an app config file

Fastest option:

```bash
make new-app NAME=billing PORT=4321
```

That creates:

```text
caddy/apps/billing.caddy
```

Equivalent manual file:

```caddy
billing.test {
  reverse_proxy localhost:4321
}
```

## 4. Reload Caddy

```bash
make reload-caddy
```

## 5. Start the app

Make sure your app is actually listening on the port you configured.

## 6. Open it

Visit:

```text
http://billing.test
```

## Common framework notes

### Vite

You may need to allow custom hosts in your Vite config.

### Next.js

If needed, make sure the dev server is bound in a way Caddy can reach.

### Webpack dev server

You may need host allowlisting depending on your config.
