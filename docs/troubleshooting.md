# Troubleshooting

A good first step is:

```bash
dev-domains doctor
```

That checks for common setup problems.

## `*.lvh.me` does not resolve

Check lookup directly:

```bash
dig flux.lvh.me
```

You should see `127.0.0.1` in the answer.

If not, check your network or DNS settings.

## Caddy returns bad gateway

That usually means the target app is not running on the port in its `caddy/apps/*.caddy` file.

Example checks:

```bash
lsof -iTCP -sTCP:LISTEN -nP | rg '9000|3001|5173|8080'
```

## App rejects the hostname

Some dev servers only allow `localhost` by default. Configure the app to allow the custom hostname.

## Port 80 is already in use

Find the conflicting process:

```bash
sudo lsof -i :80
```

Stop it or run Caddy differently.
